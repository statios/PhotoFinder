//
//  ViewController.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import UIKit
import ReactorKit

class SearchViewController: BaseViewController, View {
  
  // MARK: - Views
  lazy var searchController = UISearchController()
  lazy var searchTableView = UITableView().then {
    $0.delegate = self
    $0.dataSource = self
    $0.register(
      SearchTableViewCell.self,
      forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    $0.rowHeight = UIScreen.main.bounds.width
  }
  
  // MARK: - Properties
  var searchDocuments = [SearchDocument]()
  
  // MARK: - LifeCycles
  init(reactor: SearchViewReactor) {
    super.init()
    self.reactor = reactor
  }
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "PhotoFinder"
    self.navigationItem.searchController = self.searchController
    self.view.addSubview(self.searchTableView)
  }
  override func setupConstraints() {
    super.setupConstraints()
    self.searchTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Reacting
  func bind(reactor: SearchViewReactor) {
    
    // Action
    self.searchController.searchBar.rx.searchButtonClicked
      .compactMap { [weak self] _ in
        let text = self?.searchController.searchBar.text
        self?.searchController.isActive = false
        return text }
      .map { Reactor.Action.search($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    self.searchTableView.rx.willDisplayCell
      .map { $0.indexPath }
      .filter { [weak self] indexPath in
        guard let `self` = self else { return false }
        return indexPath.row == self.searchDocuments.count - 1
      }
      .map { _ in Reactor.Action.pagination }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // State
    reactor.state.compactMap { $0.searchResponse }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] searchResponse in
        self?.searchDocuments = searchResponse.documents
        self?.searchTableView.reloadData()
      })
      .disposed(by: self.disposeBag)
    reactor.state.compactMap { $0.errorMessage }
      .subscribe(onNext: { errorMessage in
        print(errorMessage)
        //TODO: Alert here
      })
      .disposed(by: self.disposeBag)
    
  }
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.searchDocuments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: SearchTableViewCell.reuseIdentifier,
      for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
    cell.bindCellBy(self.searchDocuments[indexPath.row])
    return cell
  }
}
