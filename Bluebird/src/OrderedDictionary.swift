//
//  OrderedDictionary.swift
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

/**
*  Implements an OrderedDictionary
*/
struct OrderedDictionary<KeyType: Hashable, ValueType> {
    
    // MARK: - TypeAlias
    
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    // MARK: - Private properties
    
    private var array = ArrayType()
    private var dictionary = DictionaryType()
    
    // MARK: - Public properties
    
    var count: Int {
        return self.array.count
    }
    
    var keys: [KeyType] {
        return self.array
    }
    
    var values: [KeyType: ValueType] {
        return self.dictionary
    }
    
    var isEmpty: Bool {
        get{
            return (self.count == 0) ? true : false
        }
    }
    
    // MARK: - Initializers
    
    /**
    Initializer
    
    :param: items A collection of objects
    
    :returns: self
    */
    init(items: [KeyType: ValueType]...) {
        
        for item: [KeyType: ValueType] in items {
            for key: KeyType in item.keys {
                self.append(item[key]!, forKey: key)
            }
        }
    }
    
    // MARK: - Observer methods
    
    /**
    Returns the last element of the collection
    Empty optional if the collection is empty
    
    :returns: A tuple (Key,Value)
    */
    func last() -> (KeyType, ValueType)? {
        
        if self.isEmpty == false {
            return self.objectAtIndex(self.count - 1)
        } else {
            return nil
        }
    }
    
    /**
    Returns the first element of the collection
    Empty optional if the collection is empty
    
    :returns: A tuple (Key,Value)
    */
    func first() -> (KeyType, ValueType)? {
        
        if self.isEmpty == false {
            return self.objectAtIndex(0)
        } else {
            return nil
        }
    }
    
    /**
    Returns the next element from the given one,
    empty optional if there is none.
    
    :param: currentKey The element we want the next from
    
    :returns: A tuple (Key,Value)
    */
    func next(currentKey: KeyType) -> (KeyType, ValueType)? {
        
        if let currentIndex = find(self.array, currentKey) {
            let nextIndex = currentIndex + 1
            if nextIndex >= self.count {
                return nil
            } else {
                return (self.array[nextIndex], self.dictionary[self.array[nextIndex]]!)
            }
        } else {
            return nil
        }
    }
    
    /**
    Returns the previous element of the given one,
    empty optional if there is none.
    
    :param: currentKey The element we want the previous one
    
    :returns: A tuple (Key,Value)
    */
    func prev(currentKey: KeyType) -> (KeyType, ValueType)? {
    
        if let currentIndex = find(self.array, currentKey) {
            let prevIndex = currentIndex - 1
            if prevIndex < 0 {
                return nil
            } else {
                return (self.array[prevIndex], self.dictionary[self.array[prevIndex]]!)
            }
        } else {
            return nil
        }
    }
    
    /**
    Return the element at the given index.
    The index needs to be greater or equal to zero, and smaller than
    the collection total count.
    
    :param: index The index of the element we want
    
    :returns: A tuple (Key,Value)
    */
    func objectAtIndex(index: Int) -> (KeyType, ValueType) {
        
        precondition(index < self.array.count && index >= 0, Logger.sharedInstance.getMessage("Index out of bounds", .Error))
        
        return (self.array[index],  self.dictionary[self.array[index]]!)
    }
    
    /**
    Returns the value for the given key. 
    Empty optional if it does not exists.
    
    :param: key The key of the object
    
    :returns: The value for the given key
    */
    func objectForKey(key: KeyType) -> ValueType? {
        
        return self.dictionary[key]
    }
    
    // MARK: - Mutating methods
    
    /**
    Adds the given element to the tail of the collection.
    
    :param: value The value to insert.
    :param: key   The key of the value.
    
    :returns: The number of elements in the collection after the append.
    */
    mutating func append(value: ValueType, forKey key: KeyType) -> Int? {
        
        self.array.append(key)
        self.dictionary[key] = value
        
        return self.count
    }
    
    /**
    Inserts a value for the given key in the given index
    If the key alredy has a value, it removes it from the collection and returns it.
    
    :param: value The value to insert
    :param: key   The key for the value
    :param: index The index to insert
    
    :returns: The value replaced.
    */
    mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType? {
    
        var adjustedIndex = index
        
        let existingValue = self.dictionary[key]
        
        if existingValue != nil {
            let existingIndex = find(self.array, key)!
            if existingIndex < index {
                adjustedIndex--
            }
            self.array.removeAtIndex(existingIndex)
        }
        
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        
        return existingValue
    }
    
    /**
    Removes the element for the given index from the collection and returns it.
    The index must be greater or equal to zero and smaller that the collection's
    total count.
    
    :param: index The index of the element to remove
    
    :returns: A tuple (Key,Value)
    */
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType) {
    
        precondition(index < self.array.count && index >= 0, Logger.sharedInstance.getMessage("Index out of bounds", .Error))
        
        return (self.array.removeAtIndex(index), self.dictionary.removeValueForKey(self.array.removeAtIndex(index))!)
    }
}

/**
*  Implements the SequenceType Protocol for OrderedDictionary
*/
extension OrderedDictionary: SequenceType {
    
    // MARK: - SequenceType Protocol
    
    /**
    Implements the generator pattern for the collection.
    
    :returns: GeneratorOf
    */
    func generate() -> GeneratorOf<Dictionary<KeyType, ValueType>> {
        
        var index = 0
        return GeneratorOf<Dictionary<KeyType, ValueType>> {
            if index >= self.count {
                return nil
            } else {
                let currentIndex = index
                index++
                return [self.array[currentIndex]: self.dictionary[self.array[currentIndex]]!]
            }
        }
    }
}

/**
*  Implement subscript operations for OrderedDictionary
*/
extension OrderedDictionary {
    
    subscript(key: KeyType) -> ValueType? {
        
        get {
            return self.dictionary[key]
        }
        
        set {
            if let index = find(self.array, key) {
                
            } else {
                self.array.append(key)
            }
            
            self.dictionary[key] = newValue
        }
    }
    
    subscript(index: Int) -> (KeyType, ValueType) {
        
        get {
            precondition(index < self.array.count && index >= 0, Logger.sharedInstance.getMessage("Index out of bounds", .Error))
            
            return (self.array[index], self.dictionary[self.array[index]]!)
        }
        
        set {
            self.insert(newValue.1, forKey: newValue.0, atIndex: index)
        }
    }
}

/**
*  Implements functional patterns for OrderedDictionary
*/
extension OrderedDictionary {
    
    /**
    Filters an OrderedDictionary by the given condition
    
    :param: condition Lambda function
    
    :returns: A filtered OrderedDictionary or empty optional
    */
    func filter(condition: (ValueType) -> Bool) -> Array<ValueType>? {
        
        var values = Array<ValueType>()
        
        for key: KeyType in self.array {
            if condition(self.dictionary[key]!) {
                values.append(self.dictionary[key]!)
            }
        }
        
        return values.isEmpty == false ? values : nil
    }
    
    /**
    Applies the function transformation to all elements in the OrderedDictionary
    
    :param: transformation A transformation function
    
    :returns: Returns an Array with the transformed elements
    */
    func map(transformation: (ValueType) -> ValueType) -> Array<ValueType>? {
    
        precondition(self.isEmpty == false, Logger.sharedInstance.getMessage("You can't map an empty OrderedDictionary", .Error))
        
        var values = Array<ValueType>()
        
        for key: KeyType in self.array {
            values.append(transformation(self.dictionary[key]!))
        }
        
        return values
    }
    
    /**
    Combines all elements in OrderedDictionary using the combine function.
    
    :param: seed    The seed to the combine function
    :param: combine The combine function
    
    :returns: The value result from the combination
    */
    func reduce<T>(seed: ValueType, combine: (ValueType, T) -> ValueType) -> ValueType {
        
        var current = seed
        for key: KeyType in self.array {
            current = combine(current, self.objectForKey(key) as T)
        }
        
        return current
    }
    
    mutating func sort(comparison: (ValueType, ValueType) -> Bool) {
        
        var array = Array(self.dictionary)
        array.sort {
            let (leftKey, leftValue) = $0
            let (rightKey, rightValue) = $1
            return comparison(leftValue, rightValue)
        }
        
        // To Finish
    }
    
    // TODO: Join, Sort, sortedSort
}
