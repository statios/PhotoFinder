//
//  Search.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

struct SearchRequest: Codable {
  let query: String
  var page: Int = 1
}

struct SearchResponse: Codable, Equatable {
  var meta: SearchMeta
  var documents: [SearchDocument]
}

struct SearchMeta: Codable, Equatable {
  let isEnd: Bool
  let pageableCount: Int
  let totalCount: Int
  var query: String?
  var page: Int = 1
  
  enum CodingKeys: String, CodingKey {
    case isEnd = "is_end"
    case pageableCount = "pageable_count"
    case totalCount = "total_count"
    case query
  }
}

struct SearchDocument: Codable, Equatable {
  let collection: String
  let datetime: String
  let displaySitename: String
  let docURL: String
  let height: Int
  let imageURL: String
  let thumbnailURL: String
  let width: Int
  
  enum CodingKeys: String, CodingKey {
    case collection, datetime
    case displaySitename = "display_sitename"
    case docURL = "doc_url"
    case height
    case imageURL = "image_url"
    case thumbnailURL = "thumbnail_url"
    case width
  }
}

class SearchErrorResponse: KakaoErrorResponse {
  let message: String
  let errorType: String
}
