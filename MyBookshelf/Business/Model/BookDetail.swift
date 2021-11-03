//
//  BookDetail.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

struct BookDetail: Decodable {
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: String
    let year: String
    let rating: String
    let desc: String
    let price: String
    let image: String
    let url: String
    let pdf: [[String: String]]
}
