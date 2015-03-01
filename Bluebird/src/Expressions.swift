//
//  Expressions.swift
//
//  Created by Alejandro Barros Cuetos on 08/02/15.
//  Copyright (c) 2015 Alejandro Barros Cuetos. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  && and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

import Foundation

/// Returns true of the String has an even number of characters, false otherwise.
public let evenElements = {(expr: String) in countElements(expr) % 2 != 0 ? false : true}

/**
Checks if the expressions is balanaced.

:param: expression The expression to check

:returns: True if the expression is balanced, false otherwise.
*/
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

/**
Checks if the given tuple, it's present in the given array.

:param: array The array to search in.
:param: tuple The tuple to search.

:returns: Bool
*/
public func isTupleInArrayOfTuples<T:Equatable>(array: [(T, T)], tuple: (T, T)) -> Bool {
    for pair in array {
        if pair.0 == tuple.0 && pair.1 == tuple.1 {
            return true
        }
    }
    
    return false
}