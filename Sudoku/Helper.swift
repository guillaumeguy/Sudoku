//
//  Util.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/14/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import Foundation

class Helper{
    static let rowCnt = 9
    
    
    static func r(_ i:Int) -> Int {
        return  (i - (i % rowCnt)) / rowCnt
    }
    
    
    static   func c(_ i:Int) -> Int {
        return i % rowCnt
    }
    
}
