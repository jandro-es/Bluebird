//
//  Stack.swift
//
//  Created by Alejandro Barros Cuetos on 22/02/15.
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

struct Stack<T>
{
    // MARK: - Internal storage
    
    var elements: [T]
    
    // MARK: - Observer properties
    
    var count: Int { return countElements(elements) }
    var isEmpty: Bool { return elements.isEmpty }
    var topItem: T? { return isEmpty ? nil : elements[count - 1] }
    
    // MARK: - Initializers
    
    init(_ elements: [T]) {
        self.elements = elements
    }
    
    init(stack: Stack<T>) {
        elements = stack.elements
    }
    
    init() {
        elements = [T]()
    }
    
    // MARK: - Mutating methods
    
    mutating func push(element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T {
        precondition(!isEmpty, Logger.sharedInstance.getMessage("Can't POP in an empty Stack", .Error))
        
        return elements.removeLast()
    }
    
}