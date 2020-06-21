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
import RxCocoa
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let serviceProvider = ServiceProvider()
    let searchViewReactor = SearchViewReactor(provider: serviceProvider)
    let searchViewController = SearchViewController(reactor: searchViewReactor)
    let navigationController = BaseNavigationController(rootViewController: searchViewController)
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
    
    self.window = window
    return true
  }
}
