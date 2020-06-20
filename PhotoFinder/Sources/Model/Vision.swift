//
//  Vision.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

struct VisionRequest: ModelType {
  let imageURL: String
}
struct VisionResponse: ModelType, KakaoResponse {
  let msg: String?
  let code: Int?
  let result: VisionResult?
}
struct VisionResult: ModelType {
  let koreanLabels: [String]
  let englishLabels: [String]
  enum CodingKeys: String, CodingKey {
    case koreanLabels = "label_kr"
    case englishLabels = "label"
  }
}
