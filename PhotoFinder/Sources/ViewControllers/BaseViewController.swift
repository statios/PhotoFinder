//
//  BaseViewController.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  // MARK: Initializing
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  // MARK: Rx
  
  var disposeBag = DisposeBag()
  
  // MARK: Layout Constraints
  
  private(set) var didSetupConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  func setupConstraints() {
    // Override point
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
