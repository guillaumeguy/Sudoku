//
//  DummyData.swift
//  Sudoku
//
// Contain dummy data for testing
//
//  Created by Guillaume Guy on 7/14/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import Foundation
class DummyData {
// https://www.websudoku.com/?level=1&set_id=596167755
  
  static  let inputDataEasy : [Loc:Int] =
    [
       Loc(r:0,c:0) : 4
      ,Loc(r:0,c:2) : 7
      ,Loc(r:0,c:4) : 9
      ,Loc(r:0,c:6) : 1

      ,Loc(r:1,c:2) : 8
      ,Loc(r:1,c:3) : 1
      ,Loc(r:1,c:5) : 4
      ,Loc(r:1,c:6) : 9
          
      ,Loc(r:2,c:1) : 2
      ,Loc(r:2,c:8) : 4
         
      ,Loc(r:3,c:0) : 2
      ,Loc(r:3,c:1) : 1
      ,Loc(r:3,c:3) : 3
      ,Loc(r:3,c:7) : 6
          
      ,Loc(r:4,c:0) : 5
      ,Loc(r:4,c:1) : 7
      ,Loc(r:4,c:2) : 3
      ,Loc(r:4,c:3) : 8
      ,Loc(r:4,c:5) : 1
      ,Loc(r:4,c:6) : 4
      ,Loc(r:4,c:7) : 9
      ,Loc(r:4,c:8) : 2

      ,Loc(r:5,c:1) : 4
      ,Loc(r:5,c:5) : 9
      ,Loc(r:5,c:7) : 1
      ,Loc(r:5,c:8) : 5
          
      ,Loc(r:6,c:0) : 7
      ,Loc(r:6,c:7) : 4

      ,Loc(r:7,c:2) : 4
      ,Loc(r:7,c:3) : 9
      ,Loc(r:7,c:5) : 7
      ,Loc(r:7,c:6) : 5

      ,Loc(r:8,c:2) : 5
      ,Loc(r:8,c:4) : 3
      ,Loc(r:8,c:6) : 2
      ,Loc(r:8,c:8) : 1
   ]
    
    static func formatData(_ input:[Loc:Int]) -> [Int?] {

        var output : [Int?] = Array.init(repeating: nil, count: 81)
        
          for i in 0..<81 {
            let l = Loc(r:Helper.r(i),c:Helper.c(i))
            if input.keys.contains(l){
                    output[i] = input[l]
                }else{
                    output[i] = nil
                }
            }
  return output
  }
    
    let inputDataEasyReformatted = formatData(inputDataEasy)
    
    
  
  
  static  let inputDataHard : [Loc:Int] =
      [
         Loc(r:0,c:2) : 4
        ,Loc(r:0,c:4) : 6
        ,Loc(r:0,c:5) : 9
        ,Loc(r:0,c:8) : 7

        ,Loc(r:1,c:2) : 7
        ,Loc(r:1,c:3) : 2
        ,Loc(r:1,c:5) : 5
        
        ,Loc(r:2,c:0) : 5
        ,Loc(r:2,c:4) : 1
        ,Loc(r:2,c:7) : 6
           
        ,Loc(r:3,c:1) : 2
        ,Loc(r:3,c:3) : 6
        ,Loc(r:3,c:7) : 1
        ,Loc(r:3,c:8) : 3
          
          //--------
          
        ,Loc(r:5,c:0) : 6
        ,Loc(r:5,c:1) : 4
        ,Loc(r:5,c:5) : 2
        ,Loc(r:5,c:7) : 8
            
        ,Loc(r:6,c:1) : 9
        ,Loc(r:6,c:4) : 7
        ,Loc(r:6,c:8) : 1

        ,Loc(r:7,c:3) : 1
        ,Loc(r:7,c:5) : 3
        ,Loc(r:7,c:6) : 5

        ,Loc(r:8,c:0) : 1
        ,Loc(r:8,c:3) : 5
        ,Loc(r:8,c:4) : 2
        ,Loc(r:8,c:6) : 3
     ]

    

    static  let inputDataVeryHard : [Loc:Int] =
        [
           Loc(r:0,c:4) : 6
          ,Loc(r:0,c:6) : 7

          ,Loc(r:1,c:1) : 3
          ,Loc(r:1,c:4) : 8
          ,Loc(r:1,c:5) : 2
          ,Loc(r:1,c:6) : 6

          ,Loc(r:2,c:3) : 5
          ,Loc(r:2,c:4) : 3
          ,Loc(r:2,c:8) : 2
             
          ,Loc(r:3,c:1) : 8
          ,Loc(r:3,c:4) : 4
          ,Loc(r:3,c:7) : 3
          
            
            ,Loc(r:4,c:1) : 1
            ,Loc(r:4,c:3) : 6
            ,Loc(r:4,c:4) : 2
            ,Loc(r:4,c:5) : 3
            ,Loc(r:4,c:7) : 4
                        //--------
            
          ,Loc(r:5,c:1) : 6
          ,Loc(r:5,c:4) : 1
          ,Loc(r:5,c:7) : 7
              
          ,Loc(r:6,c:0) : 5
          ,Loc(r:6,c:4) : 7
          ,Loc(r:6,c:5) : 8

          ,Loc(r:7,c:2) : 8
          ,Loc(r:7,c:3) : 3
          ,Loc(r:7,c:4) : 9
          ,Loc(r:7,c:7) : 6
            
          ,Loc(r:8,c:2) : 1
          ,Loc(r:8,c:4) : 5
       ]
    
    let inputDataVeryHardReformatted = formatData(inputDataVeryHard)

}
