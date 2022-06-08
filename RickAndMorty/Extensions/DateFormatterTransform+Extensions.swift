//
//  DateFormatterTransform+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import ObjectMapper

extension DateFormatterTransform {
  static var rickAndMortyDateFormatter: DateFormatterTransform = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return DateFormatterTransform(dateFormatter: dateFormatter)
  }()
}
