//
//  MyBookShelfApiError.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

enum MyBookShelfApiError: Error {
    case unsupportedUrl
    case retrieveFailed
    case parseFailed
}
