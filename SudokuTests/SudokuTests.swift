//
//  SudokuTests.swift
//  SudokuTests
//
//  Created by Guillaume Guy on 7/10/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import XCTest
@testable import Sudoku

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}


class SudokuTests: XCTestCase {
    
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExampleUnit() throws {
        
    }
    
    func testExampleBigSquare() throws {
        
        let s = State(startingPoint: [:])
        
        XCTAssert(s.bigSquare(loc:Loc(r: 4, c: 1)) == (1,0))
        let indicesQ = s.bigSquareIndexes(bigR: 1, bigC: 0)
        XCTAssert(indicesQ.map{$0.1}.max() == 2)
        
        XCTAssert(s.bigSquare(loc:Loc(r: 0, c: 0)) == (0,0))
        XCTAssert(s.bigSquare(loc:Loc(r: 3, c: 0)) == (1,0))
        XCTAssert(s.bigSquare(loc:Loc(r: 8, c: 8)) == (2,2))
        
        
        
    }
    
    func testExampleBigSquareIndex() throws {
        let s = State(startingPoint: [:])
        let indices = s.bigSquareIndexes(bigR: 0, bigC: 0)
        let indices2 = s.bigSquareIndexes(bigR: 2, bigC: 2)
        
        let sol = [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)]
        XCTAssert(indices.map{$0.1 * 9 + $0.0}.sorted() == sol.map{$0.1 * 9 + $0.0}.sorted())
        
        let sol2 = sol.map{ ($0.0 + 2 * 3, $0.1 + 2 * 3 )}
        XCTAssert(indices2.map{$0.1 * 9 + $0.0}.sorted() == sol2.map{$0.1 * 9 + $0.0}.sorted())
        
    }
    
    
    func testExampleEasy() throws {
        
        let s = try! Sudoku(startingPoint: DummyData.inputDataEasy,verbose: false)
        
        XCTAssert(try! s.solve().1 == .SolvedAndValidated)
        
    }
    
    func testExampleHard() throws {
        
        let s = try! Sudoku(startingPoint: DummyData.inputDataHard,verbose: true)
        
        XCTAssert(try! s.solve().1  == .SolvedAndValidated)
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    func testnunique() throws {
        XCTAssert([1,2,3].nunique() == 3 )
        XCTAssert([1,2,3,3].nunique() == 3 )
        
    }
    
}
