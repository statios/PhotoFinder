//
//  KakaoService.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

final class KakaoService {
  private let kakaoAPI = MoyaProvider<KakaoAPI>()
  func getSearch(_ parameters: SearchRequest) -> Single<SearchResponse> {
    kakaoAPI.rx
      .request(.search(parameters))
      .map(SearchResponse.self)
  }
  func getVision(_ parameters: VisionRequest) -> Single<VisionResponse> {
    kakaoAPI.rx
      .request(.vision(parameters))
      .map(VisionResponse.self)
  }
}
