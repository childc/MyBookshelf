//
//  SearchResult.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let page: Int?
    let books: [Book]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case page
        case books
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        total = Int(try container.decode(String.self, forKey: .total)) ?? 0
        books = try container.decode([Book].self, forKey: .books)
        if let page = try? container.decode(String.self, forKey: .page) {
            self.page = Int(page)
        } else {
            self.page = nil
        }
    }
    
    init(total: Int, page: Int? = nil, books: [Book]) {
        self.total = total
        self.page = page
        self.books = books
    }
}

extension SearchResult {
    struct Book: Decodable {
        let title: String
        let subtitle: String
        let isbn13: String
        let price: String
        let image: String
        let url: String
    }
}
