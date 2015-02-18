//
//  Expressions.swift
//  Bluebird
//
//  Created by Alejandro Barros on 22/02/15.
//  Copyright (c) 2015 Alejandro Barros Cuetos. All rights reserved.
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
        let balancedExpression = "[()]{[()]})"
        let unBalancedExpression = "{{}][[()[["
        
        XCTAssert(isExpressionBalanced(emptyExpression) == true, "emptyExpression is balanced")
        XCTAssert(isExpressionBalanced(unevenExpression) == false, "unevenExpression is not balanced")
        XCTAssert(isExpressionBalanced(balancedExpression) == true, "balancedExpression is balanced")
        XCTAssert(isExpressionBalanced(unBalancedExpression) == false, "unBalancedExpression is not balanced")
    }
}
