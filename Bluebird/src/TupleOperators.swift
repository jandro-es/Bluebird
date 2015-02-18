//
//  TupleOperators.swift
//  Bluebird
//
//  Created by Alejandro Barros on 22/02/15.
//  Copyright (c) 2015 Alejandro Barros Cuetos. All rights reserved.
//

import Foundation

func ==<T:Equatable>(tuple1:(T,T),tuple2:(T,T)) -> Bool {
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}