//
//  SearchViewReactor.swift
//  PhotoFinder
//
//  Created by Stat.So on 2020/06/21.
//  Copyright © 2020 Stat.So. All rights reserved.
//

import ReactorKit

class SearchViewReactor: Reactor {
  enum Action {
    case search(String)
    case pagination
  }
  enum Mutation {
    case setSearchResponse(SearchResponse)
    case setErrorMessage(String)
    case setNextPage(SearchMeta, [SearchDocument])
  }
  struct State {
    var searchResponse: SearchResponse?
    var errorMessage: String?
  }
  let provider: ServiceProvider
  var initialState: State
  init(provider: ServiceProvider) {
    self.provider = provider
    self.initialState = State()
  }
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .search(keyword):
      let searchRequest = SearchRequest(query: keyword)
      return Observable.create { emitter in
       self.provider.kakaoService.search(searchRequest)
        .subscribe(onSuccess: { searchResponse in
          var searchResponseWithQuery = searchResponse
          searchResponseWithQuery.meta.query = keyword
          emitter.onNext(Mutation.setSearchResponse(searchResponseWithQuery))
        }, onError: { error in
          guard let kakaoError = error as? KakaoError else { return }
          emitter.onNext(Mutation.setErrorMessage(kakaoError.message))
        })
      }
    case .pagination:
      guard let meta = self.currentState.searchResponse?.meta else { return .empty() }
      guard let query = self.currentState.searchResponse?.meta.query else { return .empty() }
      guard !meta.isEnd else { return .empty() } // if page isEnd is true then no more reqeust
      let searchRequest = SearchRequest(query: query, page: meta.page + 1)
      return Observable.create { emitter in
       self.provider.kakaoService.search(searchRequest)
        .subscribe(onSuccess: { searchResponse in
          var newMetaData = searchResponse.meta
          newMetaData.query = query
          newMetaData.page = meta.page + 1
          emitter.onNext(Mutation.setNextPage(newMetaData, searchResponse.documents))
        }, onError: { error in
          guard let kakaoError = error as? KakaoError else { return }
          emitter.onNext(Mutation.setErrorMessage(kakaoError.message))
        })
      }
    }
  }
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    newState.errorMessage = nil
    switch mutation {
    case let .setSearchResponse(searchResponse):
      newState.searchResponse = searchResponse
    case let .setErrorMessage(errorMessage):
      newState.errorMessage = errorMessage
    case let .setNextPage(newMeta, appendingDocuments):
      newState.searchResponse?.meta = newMeta
      newState.searchResponse?.documents.append(contentsOf: appendingDocuments)
    }
    return newState
  }
}
