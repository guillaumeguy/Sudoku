//
//  Sokudo.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/10/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import Foundation
import SwiftPriorityQueue


enum StateStatus {
    case Solved // But not validated
    case SolvedAndValidated // Nothing else to do
    case Blocked // Branch Search Needed
    case Bug // Something wrong
    case Unsolveable // Something wrong
}

class Sudoku {
    
    enum Sudo: Error {
        case NotSolveable(String)
        case RuleNotImplemented(String)
        case BugFound(String)
    }
    
    
    static let cellCnt:Int = 81
    static let rowCnt:Int = Int(sqrt(Double(cellCnt)))
    static let colCnt:Int = rowCnt
    var q : PriorityQueue<State> = PriorityQueue<State>(ascending: false)
    
    let verbose : Bool
    
    
    init(startingPoint sp: [Loc:Int],verbose:Bool=true) throws {
        
        self.verbose = verbose

        let state = State(startingPoint: sp,verbose: verbose)
        
        q.push(state)
        
        if self.verbose {
            print("candidates",state.candidates.count,state.candidates[0].count)
            print("candidates[3][5]",state.candidates[3][5])
            print("cells left cnt",state.cellsLeft.count)
        }
                    
        verbose ? state.printGameState() : nil
        
        // make sure it's solveable
        if(!state.isSolveable()){
            throw Sudo.NotSolveable("Not solveable - bad input")
        }
    }
    
    func solve() throws -> (State?,StateStatus) {
        
        while !q.isEmpty{
            let s = q.pop()!
            
            let stateStatus = s.solve()
            
            
            if stateStatus == .Bug {
                throw Sudo.BugFound("bug somewhere")
            }
            else if stateStatus == .Blocked {
                
                self.verbose ? print("--- Blocked ---") : nil
                
                if let currentState = s.copy() as? State{
                    
                    if let bestCell = currentState.bestCellToExploreNext() {
                        
                        for val in s.candidates[bestCell.r][bestCell.c]{
                            if let branchState = s.copy() as? State{
                                self.verbose ? print("enqueuing \(val) in \(bestCell)") : nil
                                
                                branchState.add(loc: bestCell, val: val)
                                q.push(branchState)
                            }
                        }
                    }
                }
            } else if stateStatus == .SolvedAndValidated {
                
                self.verbose ? print("final status") : nil
                self.verbose ? s.printGameState() : nil
                return (s,s.validate())
                
            }
            else {
                return (s,stateStatus)
            }
        }
        return (nil,.Unsolveable)
    }
    
    
}
