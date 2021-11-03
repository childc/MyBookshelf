//
//  BookShelfApiError.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

enum BookShelfApiError: Error {
    case unsupportedUrl
    case retrieveFailed
    case parseFailed
}
