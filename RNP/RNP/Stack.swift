//
//  Stack.swift
//  RNP
//
//  Created by Dongwoo Pae on 9/10/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

//setting up stack as generic type
struct Stack <T> : ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    //we can represent stack

    private(set) var items: [T]
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.items = elements
    }
    
    init(_ initialElements: [T] = [T]()) {
        self.items = initialElements
    }
    
    mutating func push(_ value: T) {
        self.items.append(value)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    
    //See the top thing on the stack without removing it
    func peak() -> T? {
        return items.last
    }
}
