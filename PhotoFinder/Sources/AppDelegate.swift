//
//  AppDelegate.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import UIKit
import RxSwift
import Then
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    let searchViewController = SearchViewController()
    window.rootViewController = searchViewController
    self.window = window
    return true
  }
}
