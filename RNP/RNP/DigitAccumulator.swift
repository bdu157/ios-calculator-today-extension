//
//  DigitAccumulator.swift
//  RNP
//
//  Created by Dongwoo Pae on 9/10/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

public struct DigitAccumulator {
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    public var digits = [Digit]() //var digit: [Digit] = []
    
    public init() {}
    
    public enum DigitAccumulatorError: Error {
        case extraDecimalPoint
        case invalidDigitNumberValue
    }
    
    public mutating func add(digit: Digit) throws {
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        case .number(let value):
            //add the value to the accumulator
            if value < 0 || 9 < value {  //only has numbers from 0 - 9 so this should be added
                throw DigitAccumulatorError.invalidDigitNumberValue
            }
        }
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    
    public func value() -> Double? {
        //Get all the digits from "digits", and turn them into a single Double.
        //if digits [1,2,3,.decimalPoint, 4,5,6] then return 123.456
        let string = digits.map {(digit) -> String in
            switch digit {
            case let .number(x): return String(x)
            case .decimalPoint: return "."
            }
        }.joined()
        return Double(string)
    }
}
