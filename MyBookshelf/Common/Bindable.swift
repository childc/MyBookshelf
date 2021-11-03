//
//  Bindable.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

class Bindable<Value> {
    var value: Value? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((Value?) -> ())?
    
    func bind(observer: @escaping (Value?) -> ()) {
        self.observer = observer
    }
}
