//
//  SearchAPI.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import Foundation
import Moya

enum KakaoAPI {
  static let key = "28d9218eb1ab2a46513547e14891ba12"
  case search(SearchRequest)
  case vision(VisionRequest)
}

extension KakaoAPI: TargetType {
  var baseURL: URL {
    switch self {
    case .search: return URL(string: "https://dapi.kakao.com")!
    case .vision: return URL(string: "https://kapi.kakao.com")!
    }
  }
  
  var path: String {
    switch self {
    case .search: return "/v2/search/image"
    case .vision: return "/v1/vision/multitag/generate"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .search: return .get
    case .vision: return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case let .search(searchRequest):
      return .requestParameters(
        parameters: [
          "query": searchRequest.query,
          "page": searchRequest.page],
        encoding: URLEncoding.queryString)
    case let .vision(visionRequest):
      return .requestParameters(
        parameters: [
          "image_url": visionRequest.imageURL],
        encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String: String]? {
    return ["Authorization": "KakaoAK \(KakaoAPI.key)"]
  }
  
}
