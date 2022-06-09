//
//  ImageProvider.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import RxSwift

protocol ImageProvider {
  func getImage(with url: URL) -> Single<UIImage>
}
