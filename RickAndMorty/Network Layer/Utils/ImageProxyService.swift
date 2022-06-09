//
//  ImageProxyService.swift
//  RickAndMorty
//
//  Created by XXX on 2.06.22.
//

import RxSwift
import UIKit

class ImageProxyService: ImageProvider {
  private let imageService: ImageProvider
  private let disposeBag = DisposeBag()
  private lazy var cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()

  init(imageService: ImageProvider) {
    self.imageService = imageService
  }

  func getImage(with url: URL) -> Single<UIImage> {
    .create { [weak self] single in
      guard let self = self else { return Disposables.create() }
      if
        let imageData = self.cache.object(forKey: url.absoluteString as NSString),
        let cachedImage = UIImage(data: imageData as Data)
      {
        single(.success(cachedImage))
      }

      self.imageService.getImage(with: url)
        .subscribe(
          onSuccess: { image in
            single(.success(image))
            if let imageData = image.pngData() as? NSData {
              self.cache.setObject(imageData, forKey: url.absoluteString as NSString)
            }
          },
          onFailure: { single(.failure($0)) }
        )
        .disposed(by: self.disposeBag)

      return Disposables.create()
    }
  }
}
