//
//  DetailViewModel.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

final class DetailViewModel {
    let bookDetail = Bindable<BookDetail>()
    
    func retrieveBookDetail(isbn13: String) {
        MyBookShelfApi.detail(isbn13: isbn13).request { [weak self] result in
            guard case let .success(recvData) = result else { return }
            guard let bookDetail = try? JSONDecoder().decode(BookDetail.self, from: recvData) else {
                print("cannot parse data: \(String(data: recvData, encoding: .ascii) ?? "no json data")")
                return
            }
            
            self?.bookDetail.value = bookDetail
        }
    }
}
