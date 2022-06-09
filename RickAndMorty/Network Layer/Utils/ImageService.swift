//
//  ImageService.swift
//  RickAndMorty
//
//  Created by XXX on 2.06.22.
//

import RxSwift
import Alamofire

class ImageService: ImageProvider {
  func getImage(with url: URL) -> Single<UIImage> {
    .create { single in
      let request = AF.request(url).response { response in
        if let error = response.error {
          single(.failure(error))
        }
        if let data = response.data, let image = UIImage(data: data) {
          single(.success(image))
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
