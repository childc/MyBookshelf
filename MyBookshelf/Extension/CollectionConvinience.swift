//
//  CollectionConvinience.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
