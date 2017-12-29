//
//  Colors.swift
//  xwing_squad_builder
//
//  Created by Alexander on 29/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import UIKit

enum AppTheme {
    case rebel
    case imperial
    case scum
}

class ColorManager {
    
    var currentTheme = AppTheme.rebel
    
    var primaryColor: UIColor {
        get {
            switch currentTheme {
            case .rebel:
                return UIColor.black
            default:
                return UIColor.black
            }
        }
    }
    
    
}
