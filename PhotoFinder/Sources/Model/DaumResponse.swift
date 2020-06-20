//
//  DaumResponse.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

protocol DaumResponse {
  var message: String? { get }
  var errorType: String? { get }
}
