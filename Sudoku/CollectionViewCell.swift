//
//  CollectionViewCell.swift
//  Sudoku
//
//  Created by Guillaume Guy on 7/13/20.
//  Copyright © 2020 Guillaume Guy. All rights reserved.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
     
    @IBOutlet weak var myLabel: UITextField!
    
    @IBAction func UpdateArrayOnEdit(_ sender: UITextField) {
        
        if (index >= 0) && viewController != nil{
            viewController!.userItems[index] = Int(self.myLabel.text!)
        }
    }
    
    // pointer to parent view
    var viewController:ViewController? = nil
    
    // index of the element in the parent's array
    var index : Int = -1

    
}
