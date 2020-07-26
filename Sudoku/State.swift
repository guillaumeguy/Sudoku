//
//  State.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/12/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import Foundation

extension State: Comparable {
static func < (lhs: State, rhs: State) -> Bool {
    return lhs.stepsCnt < rhs.stepsCnt
}
}

extension Array where Element: Comparable & Hashable  {
    func nunique() -> Int {
        var s = Set<Element>()
        var cnt = 0
        for x in self {
            let t = x as Element
            if !s.contains(x) {
                s.insert(t)
                cnt += 1
            }
        }
        return cnt
    }
}

class State:NSObject, NSCopying {
    
    // TO-DO : Get them from Sokudo
    static let cellCnt = 81
    static let rowCnt = 9
    static let colCnt = 9
    let verbose:Bool
    
    static func == (lhs: State, rhs: State) -> Bool {
           return lhs.stepsCnt == rhs.stepsCnt
       }

    
    var elements : [[Int8?]] = [[Int8?]](repeating: [Int8?](repeating: nil, count: colCnt ), count: rowCnt)
    var candidates : [[Set<Int8>]] = [[Set<Int8>]](repeating: [Set<Int8>](repeating: Set(Int8(1)..<Int8((10))), count: colCnt)  , count: rowCnt)
    var cellsLeft : Set<Loc> = populateCellsLeft()
    var steps : [(Loc,Int8)] = []
    var stepsCnt : Int = 0
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let dummyS : [Loc:Int] = [:]
        let copy = State(startingPoint:dummyS) //elements: elements, candidates : candidates,cellsLeft:cellsLeft,steps: steps)
        copy.elements = elements
        copy.candidates = candidates
        copy.cellsLeft = cellsLeft
        copy.steps = steps
        copy.stepsCnt = stepsCnt
        // elements: elements, candidates : candidates,cellsLeft:cellsLeft
        
          return copy
      }
    
    
    static func populateCellsLeft() -> Set<Loc>  {
        var a = Set<Loc>()
        for r in 0..<rowCnt{
            for c in 0..<colCnt{
                a.insert(Loc(r: r, c: c))
            }
        }
        return  a
    }
    
    init(startingPoint sp: [Loc:Int],verbose:Bool=false){
        // insert
        self.verbose = verbose
        super.init()
          for (loc, value) in sp{
            add(loc: loc, val: Int8(value))
          }
    }
    
    
    
    func solve() -> StateStatus {
    
       while !cellsLeft.isEmpty{
        self.verbose ? print("state \(self.stepsCnt)") : nil 
           
        // Found next step
        if let (nextC,val) = nextCell() {
           self.verbose ? print("Solution: adding \(val) at \(nextC)") : nil
           add(loc: nextC, val: val)
           self.stepsCnt += 1
           self.steps.append( (nextC,val) )
           
            self.verbose ? printGameState() : nil
        
        } else {
            // no solution found
            self.verbose ? print("Could not find a solution - Branch exploration needed") : nil
            return StateStatus.Blocked
        }
       }
       
       let solved = validate()
       return solved
       
   }

    
   /*
    If any cell candidates is empty, throw exception
    */
   func isSolveable() -> Bool {
    
    // no empty possibility
       for candidate in candidates{
           if candidate.isEmpty{
               return false
           }
       }
    
    // no duplication
    for r in 0..<9 {
        let e = elements[r].compactMap{$0}
        if e.count != e.nunique() {
            return false
        }
    }
    
    for c in 0..<9 {
        let e = elements.compactMap{$0[c]}
        if e.count != e.nunique() {
          return false
        }
    }
       return true
   }
   
   func nextCell() -> (Loc,Int8)?  {
       
       // first, solve the cell that has only 1 candidate
       for cell in cellsLeft {
           let s = candidates[cell.r][cell.c]
           if s.count == 1 {
               return (cell,s.first!)
           }
       }
    self.verbose ? print("no single candidate found - simple heuristics") : nil
           
       // Run bigSquareSingleCandidate
       let sol = bigSquareSingleCandidate()
       if let loc = sol.0  {
           return (loc,sol.1)
       }
   
       
    return nil
      //  throw Sudo.RuleNotImplemented("No easy solution")
      // return nil
   }
   
   /*
    For each bigSquare, identify a candidate that can only fits into 1 cell
    */
   func bigSquareSingleCandidate() -> (Loc?,Int8){
    self.verbose ? print("Entering bigSquareSingleCandidate loop") : nil
       for bigR in 0..<3{
           for bigC in 0..<3{
               let valToCandidates = allCandidatesBigSquare(bigR: bigR, bigC: bigC)
               
               if let s = valToCandidates.first( where: {$0.value.count == Int8(1) && cellsLeft.contains($0.value[0]) }) {
                self.verbose ? print("\(s.value[0]),\(s.key) has been found to solve the bigSquareSingleCandidate rule") :nil
                   return (s.value[0],s.key)
               }
           }
       }
       return (nil,0)
       
   }
   
   func allCandidatesBigSquare(bigR:Int,bigC:Int) -> [Int8:[Loc]]  {
       var valToCandidates : [Int8:[Loc]] = [:]
       for (r,c) in bigSquareIndexes(bigR: bigR, bigC: bigC){
           for cand in candidates[r][c] {
               if valToCandidates.keys.contains(cand){
                   // add to dict
                   valToCandidates[cand]?.append(Loc(r:r,c:c))
               } else {
                   valToCandidates[cand] = [Loc(r:r,c:c)]
               }
           }
       }
       return valToCandidates
   }
   
   
func validate() -> StateStatus {
       for r in 0..<Self.rowCnt {
           let s = elements[r].compactMap{$0}.reduce(Int8(0), +)
           if s != 45 {
            return .Bug
           }
       }
       
       for c in 0..<Self.colCnt {
           let s = elements.compactMap{$0[c]}.reduce(Int8(0), +)
          if s != 45 {
              return .Bug
          }
       }
    return .SolvedAndValidated
       
   }
   
   func printGameState() -> Void {
       
       let charCnt = 20
       
       print("---- Elements ----")
       
       print(String(repeating: "-", count: 20))
    for r in 0..<Self.rowCnt{
           let row = elements[r]
           
           let s = row.map{ $0 != nil ? String($0!) : " " }.joined(separator: ",")
           print("|",s,"|")
           print(String(repeating: "-", count: charCnt))
       }
       print(String(repeating: "-", count: charCnt))
       
       print("---- candidates ----")
       
       for (i,candidatesSet) in candidates.enumerated(){
           print(i,candidatesSet)
           print(String(repeating: "-", count: charCnt))
       }
       
       print("---- left cells ------")
       print(cellsLeft)
       
   }
   
   
   func bigSquare( loc:Loc) -> (Int,Int) {
       let r1 =  (loc.r - loc.r % 3) / 3
       let c1 =  (loc.c - loc.c % 3) / 3
       return (r1,c1)
   }
   
   
   // Returns an Array of (row,col)
   func bigSquareIndexes(bigR:Int,bigC:Int) -> [(Int,Int)] {
       
       var results : [(Int,Int)] = [(Int,Int)](repeating: (0,0), count: Self.rowCnt)
       
       var i = 0
       for row in 0..<3{
           for column in 0..<3{
               results[i] =  (bigR * 3 + row,bigC * 3 + column)
               i += 1
           }
       }
       return results
   }
   /*
    remove the possibility from all cells of the bigSquare
    */
   func updateBigSquare(loc:Loc,val:Int8) -> Void {
       let (bigR,bigC) = bigSquare(loc: loc)
       for (r,c) in bigSquareIndexes(bigR: bigR, bigC: bigC){
        self.verbose ? print("BQ: removing \(val) from \(r),\(c)") : nil
            candidates[r][c].remove(val)
       }
       return
   }
   
   
   func add(loc:Loc,val:Int8) -> Void{
    self.verbose ? print("populating \(loc) cell with \(val)") : nil
       
       elements[loc.r][loc.c] = val
       
       // update candidates
       updateRowAfterAddition(r: loc.r, val: val)
       updateColumnAfterAddition(c: loc.c, val: val)
       updateBigSquare(loc:loc,val:val)
       
       // we have solutions
       candidates[loc.r][loc.c] = Set([Int8(val)])
       cellsLeft.remove(loc)
       
       
       return
   }
   
   // Update columns and row
   func updateRowAfterAddition(r:Int,val:Int8) -> Void{
    self.verbose ? print("removing \(val) from row \(r)") : nil
    for c in 0..<Self.colCnt{
           candidates[r][c].remove(val)
       }
       return
   }
   
   func updateColumnAfterAddition(c:Int,val:Int8) -> Void{
    self.verbose ? print("removing \(val) from col \(c)") : nil
       for r in 0..<Self.rowCnt{
           candidates[r][c].remove(val)
       }
       return
   }
    
    func bestCellToExploreNext() -> Loc? {
        if let bc = cellsLeft.first {
            var bestCellCandidate = bc
            var l =  candidates[bestCellCandidate.r][bestCellCandidate.c].count
            
            for cell in cellsLeft{
                if candidates[cell.r][cell.c].count < l {
                    l = candidates[cell.r][cell.c].count
                    bestCellCandidate = cell
                }
            self.verbose ? print("best cell is \(bestCellCandidate) with cardinality = \(l)") : nil
            return bestCellCandidate
            }
        }
        return nil
    }
    
}


    
