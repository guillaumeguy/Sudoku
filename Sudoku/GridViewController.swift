//
//  GridViewController.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/12/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import UIKit


/*

class GridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var data : [SudokuCell] = Array(repeating: SudokuCell(number:1), count: 81)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        let sectionInset = UIEdgeInsets(top:15, left:15, bottom:15, right:15 )
        let itemRowCount = 9
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        /*
         let cellSize = UIScreen.main.bounds.width / 3
         layout.sectionInset.left = 10
         layout.sectionInset.right = 10
         collectionView.contentSize.width = 100
         
         layout.itemSize = CGSize( width:cellSize, height:cellSize)
         layout.minimumInteritemSpacing = 10
         layout.minimumLineSpacing = 10
         
         */
        collectionView!.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset.top = 100
        layout.sectionInset.left = 30
        layout.sectionInset.right = 30
        collectionView.contentSize.width = UIScreen.main.bounds.width
        print("collectionView.contentSize.width",collectionView.contentSize.width)
        let mip = Double(layout.minimumInteritemSpacing)
        print("mip",mip)
        let rowWidth = collectionView.contentSize.width -  layout.sectionInset.left - layout.sectionInset.right
        let numerator = (Double(rowWidth) - mip * (Double(itemRowCount) - 1.0) )
        let itemWidth = numerator / Double(itemRowCount)
        let itemHeight = itemWidth ;
        print(itemWidth,itemHeight)
        layout.itemSize = CGSize(width:itemWidth, height:itemHeight)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.configure(with: data[indexPath.row])
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.backgroundColor = .green
        //. = "Test"

        
        print("HERE")
     }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

    
}
 */
