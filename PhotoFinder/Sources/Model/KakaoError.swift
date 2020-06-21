//
//  KakaoError.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

enum KakaoError: Error {
  case unknwon
  case with(message: String)
}
extension KakaoError {
  var message: String {
    switch self {
    case .unknwon: return self.localizedDescription
    case let .with(message: message): return message
    }
  }
}
