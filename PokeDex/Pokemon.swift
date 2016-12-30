//
//  Pokemon.swift
//  PokeDex
//
//  Created by Dylan wichman on 12/29/16.
//  Copyright © 2016 Bulletproof Interactive. All rights reserved.
//

import Foundation


class Pokemon{
    
    fileprivate var _name: String!
    fileprivate var _id: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(name: String, id: Int){
        self._name = name
        self._id = id
    }
    
}
