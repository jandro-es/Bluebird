//
//  Expressions.swift
//
//  Created by Alejandro Barros Cuetos on 03/02/15.
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
import XCTest

class ExpressionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEvenElements() {
        
        let evenExpression = "[[[[]]]]"
        let unevenExpression = "[[[[]]]"
        
        XCTAssert(evenElements(evenExpression) == true, " The expression is even")
        XCTAssert(evenElements(unevenExpression) == false, "The expression is not even")
        
    }

    func testIsExpressionBalanced() {
        
        let emptyExpression = ""
        let unevenExpression = "[[]"
        let balancedExpression = "[()]{[()]}"
        let unBalancedExpression = "{{}][[()[["
        
        XCTAssert(isExpressionBalanced(emptyExpression) == true, "emptyExpression is balanced")
        XCTAssert(isExpressionBalanced(unevenExpression) == false, "unevenExpression is not balanced")
        XCTAssert(isExpressionBalanced(balancedExpression) == true, "balancedExpression is balanced")
        XCTAssert(isExpressionBalanced(unBalancedExpression) == false, "unBalancedExpression is not balanced")
    }
}
