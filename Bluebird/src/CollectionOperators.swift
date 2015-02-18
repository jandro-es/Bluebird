//
//  CollectionOperators.swift
//  Bluebird
//
//  Created by Alejandro Barros on 08/02/15.
//  Copyright (c) 2015 Alejandro Barros Cuetos. All rights reserved.
//

import Foundation

/**
*  Dictionary Equatable
*/
extension Dictionary: Equatable {}

public func ==<Key, Value>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Bool {
    
    return Array(lhs.keys) == Array(rhs.keys)
}

/**
*  OrderedDictionary Equatable
*/
extension OrderedDictionary: Equatable {}

/**
Equality operator

:param: lhs OrderedDictionary
:param: rhs OrderedDictionary

:returns: True if lhs is equal to rhs false otherwise.
*/
func ==<T, U>(lhs: OrderedDictionary<T, U>, rhs: OrderedDictionary<T, U>) -> Bool {
    
    return lhs.values == rhs.values && lhs.keys == rhs.keys
}