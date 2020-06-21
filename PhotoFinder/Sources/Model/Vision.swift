//
//  Vision.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

struct VisionRequest: Codable {
  let imageURL: String
}

struct VisionResponse: Codable {
  let result: VisionResult
}

struct VisionResult: Codable {
  let koreanLabels: [String]
  let englishLabels: [String]
  enum CodingKeys: String, CodingKey {
    case koreanLabels = "label_kr"
    case englishLabels = "label"
  }
}

class VisionErrorResponse: KakaoErrorResponse {
  let message: String
  let code: Int
  enum CodingKeys: String, CodingKey {
    case message = "msg"
    case code
  }
}
