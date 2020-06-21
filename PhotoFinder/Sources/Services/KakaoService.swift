//
//  KakaoService.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import Moya
import RxSwift

final class KakaoService {
  private let kakaoAPI = MoyaProvider<KakaoAPI>()
  func search(_ parameters: SearchRequest) -> Single<SearchResponse> {
    return kakaoAPI.rx
      .request(.search(parameters))
      .catchError { error in throw KakaoError.with(message: error.localizedDescription) }
      .catchErrorResponse(SearchErrorResponse.self)
      .map(SearchResponse.self)
  }
  func vision(_ parameters: VisionRequest) -> Single<VisionResponse> {
    return kakaoAPI.rx
      .request(.vision(parameters))
      .map(VisionResponse.self)
  }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
  func catchErrorResponse<T: KakaoErrorResponse>(_ type: T.Type) -> Single<Element> {
    return flatMap { response in
      guard (200...299).contains(response.statusCode) else {
        do {
          let errorResponse = try response.map(type.self)
          throw KakaoError.with(message: errorResponse.message)
        } catch {
          throw error
        }
      }
      return .just(response)
    }
  }
}
