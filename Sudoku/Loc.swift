//
//  Loc.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/12/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import Foundation

struct Loc:Hashable{
   let r:Int
   let c:Int
   
   var hashValue: Int {
       return (r * 9 + c).hashValue
   }
   static func == (lhs: Loc, rhs: Loc) -> Bool {
       return lhs.r == rhs.r && (lhs.c == rhs.c)
   }
}

