//
//  ViewController.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/13/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import UIKit

let identifier = "SudokuCell"



class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellCnt = 81
    let rowCnt = 9
    
    /*
     To be implemented. For now, just refresh
     */
    @IBAction func ShowLabels(_ sender: Any) {
        
        self.collectionView!.reloadData()
        
    }
    
    @IBOutlet weak var SolveInd: UISwitch!
    
    // state of problem
    @IBOutlet weak var status: UILabel!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func SolvedInd(_ sender: Any) {
        print("action",SolveInd.isOn)
        
        
        if !SolveInd.isOn {
            status.text = "Press Solve it !"
            self.collectionView!.reloadData()
            return
        }
        
        status.text = "Crunching numbers ... "
        
        // solve it
        var startingPoint : [Loc:Int] = [:]
        
        for cellID in 0..<cellCnt{
            if let i = userItems[cellID] {
                let r = Helper.r(cellID)
                let c = Helper.c(cellID)
                
                // save user data first
                if let userI = getUserInput(collectionView,cellForItemAt:cellID) {
                    
                    userI != "" ? userItems[cellID] = Int(userI) : nil
                }
                startingPoint[Loc(r:r,c:c)] = i
            }
            
        }
        
        if let sudoku = try? Sudoku(startingPoint:startingPoint,verbose: false) {
            
            
            if let (state,stateStatus) = try? sudoku.solve() {
                
                switch stateStatus {
                case .Blocked: self.status.text = "Blocked"
                self.SolveInd.isOn = false
                case .SolvedAndValidated:
                    self.status.text = "Solved and val !"
                    self.solution = state!.elements
                    self.collectionView!.reloadData()
                case .Solved:
                    self.status.text = "Solved !"
                case .Bug:
                    self.status.text = "Bug !"
                    self.SolveInd.isOn = false
                case .Unsolveable:
                    self.status.text = "Unsolveable!"
                    self.SolveInd.isOn = false
                }
                return
            }
            return
        } else {
            self.status.text = "Wrong starting point. Please verify input"
            self.SolveInd.isOn = false
        }
    }
    
    // format
    fileprivate var itemsPerRow: CGFloat {
        return CGFloat(self.rowCnt)
    }
    
    
    
    
    //var userItems = DummyData().inputDataVeryHardReformatted
    lazy var userItems :[Int?] = Array.init(repeating: nil, count: cellCnt)
    
    
    var solution : [[Int8?]] = [[]]
    let dummyState = State(startingPoint:[Loc(r:1,c:2):12],verbose: false)
    
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right:30)
    let interitemSpace = 0
    
    /*
     return row given a index
     row 0 = 0..8
     row 1 = 9..15
     ..
     */
    func r(_ i:IndexPath) -> Int {
        return  (i.item - (i.item % rowCnt)) / rowCnt
    }
    
    /*
     return column given a index
     ..
     */
    func c(_ i:IndexPath) -> Int {
        return i.item % rowCnt
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionPadding =  sectionInsets.right + sectionInsets.left
        let interitemPadding = CGFloat(max(0, Int(itemsPerRow - 1.0)) * interitemSpace)
        let availableWidth = collectionView.bounds.width - sectionPadding - interitemPadding
        let widthPerItem = availableWidth / itemsPerRow
        
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interitemSpace)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIDevice.current.setValue(self.preferredInterfaceOrientationForPresentation.rawValue, forKey: "orientation")
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCnt
    }
    
    func getUserInput(_ collectionView: UICollectionView,cellForItemAt i: Int) -> String? {
        
        let indexPath = IndexPath(item: i, section: 0)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CollectionViewCell {
            return cell.myLabel.text
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        
        cell.viewController = self
        cell.index = indexPath.item
        
        
        if let v = userItems[indexPath.item] {
            cell.myLabel.text =  String(v)
            cell.myLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            cell.myLabel.textColor = .black
            
        } else if solution.count>1 && SolveInd.isOn {
            if let v = solution[Helper.r(indexPath.item)][Helper.c(indexPath.item)] {
                cell.myLabel.text =  String(v)
                cell.myLabel.textColor = .systemBlue
            }
        } else {
            cell.myLabel.text = ""
            cell.myLabel.textColor = .black
        }
        
        
        let bs = dummyState.bigSquare(loc: Loc(r:r(indexPath) ,c:c(indexPath)))
        
        cell.backgroundColor = (bs.0 * 3 + bs.1) % 2 == 0 ? UIColor.systemGray : UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        
        
        //cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
