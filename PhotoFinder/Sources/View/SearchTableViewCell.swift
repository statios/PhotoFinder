//
//  SearchTableViewCell.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {
  
  static let reuseIdentifier = "SearchTableViewCell"
  
  let thumbnailImageView = UIImageView().then {
    $0.clipsToBounds = true
    $0.contentMode = .scaleAspectFill
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.thumbnailImageView.image = nil
  }
  
  override func initialize() {
    super.initialize()
    self.contentView.addSubview(self.thumbnailImageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.thumbnailImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.top.equalToSuperview().offset(8)
      make.height.equalTo(UIScreen.main.bounds.width-16)
      make.width.equalTo(UIScreen.main.bounds.width-32)
    }
  }
  
  func bindCellBy(_ item: SearchDocument) {
    self.thumbnailImageView.kf.setImage(with: URL(string: item.thumbnailURL))
  }
  
}
