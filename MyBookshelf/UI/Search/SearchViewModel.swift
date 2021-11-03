//
//  SearchViewModel.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

final class SearchViewModel {
    let searchResult = Bindable<SearchResult>()
    
    func isbn13(index: Int) -> String? {
        return searchResult.value?.books[safe: index]?.isbn13
    }
    
    func search(query: String, page: Int? = nil) {
        MyBookShelfApi.search(query: query, page: page).request { [weak self] result in
            guard case let .success(recvData) = result else { return }
            guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: recvData) else {
                print("cannot parse data: \(String(data: recvData, encoding: .ascii) ?? "no json data")")
                return
            }
            
            guard let currentSearchResult = self?.searchResult.value,
                  currentSearchResult.page ?? 0 < searchResult.page ?? 0 else {
                      self?.searchResult.value = searchResult
                      return
                  }
            
            let expandedSearchResult = SearchResult(
              total: searchResult.total,
              page: searchResult.page,
              books: currentSearchResult.books + searchResult.books)
            
            self?.searchResult.value = expandedSearchResult
        }
    }
    
    func retrieveNewBooks() {
        MyBookShelfApi.new.request { [weak self] result in
            guard case let .success(recvData) = result,
                  let searchResult = try? JSONDecoder().decode(SearchResult.self, from: recvData) else { return }
            
            self?.searchResult.value = searchResult
        }
    }
}
