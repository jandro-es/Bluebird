//
//  Expressions.swift
//  Bluebird
//
//  Created by Alejandro Barros on 22/02/15.
//  Copyright (c) 2015 Alejandro Barros Cuetos. All rights reserved.
//

import Foundation

public let evenElements = {(expr: String) in countElements(expr) % 2 != 0 ? false : true}

public func isExpressionBalanced(expression: String) -> Bool {
    if !evenElements(expression)
    {
        return false
    }
    
    let openingChars: String = "([{"
    let matchingChars: Array = [("(", ")"), ("[","]"), ("{","}")]
    var stack: Stack = Stack<Character>()
    
    for char: Character in expression {
        if contains(openingChars, char) {
            stack.push(char)
        } else {
            if stack.isEmpty {
                return false
            }
            let tuple = ("\(stack.pop())", "\(char)")
            if isTupleInArrayOfTuples(matchingChars, tuple) == false {
                return false
            }
        }
    }
    
    return stack.isEmpty
}

public func isTupleInArrayOfTuples<T:Equatable>(array: [(T, T)], tuple: (T, T)) -> Bool {
    for pair in array {
        if pair == tuple {
            return true
        }
    }
    
    return false
}