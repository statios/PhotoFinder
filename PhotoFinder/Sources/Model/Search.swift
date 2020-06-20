//
//  Search.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

struct SearchRequest: ModelType {
  let query: String
  let page: Int
}

struct SearchResponse: ModelType, KakaoResponse {
  let msg: String?
  let code: Int?
  let meta: SearchMeta?
  let documents: [SearchDocument]?
}

struct SearchMeta: Codable {
  let isEnd: Bool
  let pageableCount: Int
  let totalCount: Int
  
  enum CodingKeys: String, CodingKey {
    case isEnd = "is_end"
    case pageableCount = "pageable_count"
    case totalCount = "total_count"
  }
}

struct SearchDocument: Codable {
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
