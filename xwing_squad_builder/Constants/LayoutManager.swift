//
//  LayoutConstants.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import UIKit

class LayoutManager {
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static let collectionViewWidth = screenWidth - 20
    
    static let modalSelectionVCheight = screenHeight - 100
    static let modalSelectionVCwidth = screenWidth - 60
    
    class func getCell(for view:UIView) -> UICollectionViewCell? {
        var superView = view.superview
        while superView != nil {
            if superView is UICollectionViewCell {
                return superView as? UICollectionViewCell
            } else {
                superView = superView?.superview
            }
        }
        return nil
    }
}

