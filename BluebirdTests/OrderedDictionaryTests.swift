//
//  OrderedDictionaryTests.swift
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

class OrderedDictionaryTests: XCTestCase {
    
    var orderedDictionary: OrderedDictionary<String, String>?
    var orderedDictionaryComplex: OrderedDictionary<String, Dictionary<String, String>>?
    let emptyOrderedDictionary = OrderedDictionary<String, String>()
    let sequenceDictionary = OrderedDictionary<String, String>(items: ["keyOne": "valueOne"], ["keyTwo": "valueTwo"], ["keyThree": "valueThree"])

    override func setUp() {
        
        super.setUp()

        orderedDictionary = OrderedDictionary(items: ["keyOne": "valueOne"], ["keyTwo": "valueTwo"], ["keyThree": "valueThree"])
        orderedDictionaryComplex = OrderedDictionary(items: ["keyOne": ["subKeyOne": "subValueOne"]], ["keyTwo": ["subKeyTwo": "subValueTwo"]])
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testInit() {
        
        XCTAssert(orderedDictionary?.count == 3, "Simple OrderedDictionary init correct count")
        XCTAssert(orderedDictionaryComplex?.count == 2, "Complex OrderedDictionary init correct count")
    }
    
    func testIsEmpty() {
        
        XCTAssert(emptyOrderedDictionary.isEmpty, "isEmpty when OrderedDictionary is empty working correctly")
        XCTAssert(orderedDictionary!.isEmpty == false, "isEmpty when OrderedDictionary is not empty working correctly")
    }
    
    func testObjectAtIndex() {
    
        let tuple = orderedDictionary!.objectAtIndex(0)
        XCTAssert(tuple.0 == "keyOne" && tuple.1 == "valueOne", "Simple OrderedDictionary objectAtIndex working properly")
        
        let tupleComplex = orderedDictionaryComplex!.objectAtIndex(0)
        XCTAssert(tupleComplex.0 == "keyOne" && tupleComplex.1 == ["subKeyOne": "subValueOne"], "Simple OrderedDictionary objectAtIndex working properly")
    }
    
    func testAppend() {
    
        orderedDictionary?.append("appendedValue", forKey: "appendedKey")
        XCTAssert(orderedDictionary?.count == 4, "Simple OrderedDictionary correct count after append")
        
        let appendedTuple = orderedDictionary!.objectAtIndex(3)
        XCTAssert(appendedTuple.0 == "appendedKey" && appendedTuple.1 == "appendedValue", "Simple OrderedDictionary correct element appended")
        
        orderedDictionaryComplex?.append(["appendedSubKey": "appendedSubValue"], forKey: "appendedKey")
        XCTAssert(orderedDictionaryComplex?.count == 3, "Complex OrderedDictionary correct count after append")
        
        let appendedComplexTuple = orderedDictionaryComplex!.objectAtIndex(2)
        XCTAssert(appendedComplexTuple.0 == "appendedKey" && appendedComplexTuple.1 == ["appendedSubKey": "appendedSubValue"], "Complex OrderedDictionary correct element appended")
    }
    
    func testLast() {
    
        let lastTuple = orderedDictionary!.objectAtIndex(orderedDictionary!.count - 1)
        let lastTestTuple = orderedDictionary!.last()!
        XCTAssert(lastTestTuple.0 == lastTuple.0 && lastTestTuple.1 == lastTuple.1, "Simple OrderedDictionary last() working properly")
        
        let lastComplexTuple = orderedDictionaryComplex!.objectAtIndex(orderedDictionaryComplex!.count - 1)
        let lastComplexTestTuple = orderedDictionaryComplex!.last()!
        XCTAssert(lastComplexTestTuple.0 == lastComplexTuple.0 && lastComplexTestTuple.1 == lastComplexTuple.1, "Complex OrderedDictionary last() working properly")
        
        XCTAssert(emptyOrderedDictionary.last() == nil, "Empty OrderedDictionary last() returning nil")
    }
    
    func testFirst() {
    
        let firstTuple = orderedDictionary!.objectAtIndex(0)
        let firstTestTuple = orderedDictionary!.first()!
        XCTAssert(firstTestTuple.0 == firstTuple.0 && firstTestTuple.1 == firstTuple.1, "Simple OrderedDictionary first() working properly")
        
        let firstComplexTuple = orderedDictionaryComplex!.objectAtIndex(0)
        let firstComplexTestTuple = orderedDictionaryComplex!.first()!
        XCTAssert(firstComplexTestTuple.0 == firstComplexTuple.0 && firstComplexTestTuple.1 == firstComplexTuple.1, "Complex OrderedDictionary first() working properly")
        
        XCTAssert(emptyOrderedDictionary.first() == nil, "Empty OrderedDictionary first() returning nil")
    }
    
    func testSequence() {
        
        for (index, item:Dictionary<String, String>) in enumerate(sequenceDictionary) {

            if index == 0 {
                XCTAssert(item == ["keyOne": "valueOne"], "Sequence case one correct")
            }
            
            if index == 1 {
                XCTAssert(item == ["keyTwo": "valueTwo"], "Sequence case two correct")
            }
            
            if index == 2 {
                XCTAssert(item == ["keyThree": "valueThree"], "Sequence case three correct")
            }
        }
    }
    
    func testNext() {
    
        let nextTuple = sequenceDictionary.next("keyOne")!
        XCTAssert(nextTuple.0 == "keyTwo" && nextTuple.1 == "valueTwo", "next() case one working properly")
        
        XCTAssert(sequenceDictionary.next("keyThree") == nil, "next() case two working properly")
        XCTAssert(sequenceDictionary.next("unknownKey") == nil, "next() case three working properly")
        XCTAssert(emptyOrderedDictionary.next("keyThree") == nil, "next() case four working properly")
    }
    
    func testPrev() {
        
        let prevTuple = sequenceDictionary.prev("keyTwo")!
        XCTAssert(prevTuple.0 == "keyOne" && prevTuple.1 == "valueOne", "prev() case one working properly")
        
        XCTAssert(sequenceDictionary.prev("keyOne") == nil, "prev() case two working properly")
        XCTAssert(sequenceDictionary.prev("unknownKey") == nil, "prev() case three working properly")
        XCTAssert(emptyOrderedDictionary.prev("keyThree") == nil, "prev() case four working properly")
    }
    
    func testSubscript() {
        
        let getValue = orderedDictionary!["keyOne"]
        XCTAssert(getValue == "valueOne", "Subcript for get value working properly")
        
        var setOrderedDictionary = OrderedDictionary<String, String>()
        setOrderedDictionary["keyOne"] = "valueOne"
        XCTAssert(setOrderedDictionary["keyOne"] == "valueOne", "Subcript for set value working properly")
        
        var indexTuple = setOrderedDictionary[0]
        XCTAssert(indexTuple.0 == "keyOne" && indexTuple.1 == "valueOne", "Subcript for get at index working properly")
        
        setOrderedDictionary[0] = ("newKey", "newValue")
        indexTuple = setOrderedDictionary[0]
        XCTAssert(indexTuple.0 == "newKey" && indexTuple.1 == "newValue", "Subcript for set at index working properly")
    }
    
    func testFilter() {
        
        var condition  = {
            (value: String) -> Bool in
            if value == "valueTwo" {
                return true
            } else {
                return false
            }
        }
        
        let result = orderedDictionary?.filter(condition)
        XCTAssert(result?.count == 1 && result![0] == "valueTwo", "filter() working properly")
    }
    
    func testMap() {
    
        var mapping = {
            (value: String) -> String in
            return value.lowercaseString
        }
        
        let result = orderedDictionary?.map(mapping)
        XCTAssert(result![0] == "valueone", "map() working properly")
        XCTAssert(result![0] != "valueOne", "map() working properly")
    }
}