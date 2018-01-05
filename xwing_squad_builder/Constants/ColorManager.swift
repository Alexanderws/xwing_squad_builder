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
    
    static var currentTheme = AppTheme.rebel
    
    
    static var primaryColor: UIColor {
        get {
            switch currentTheme {
            case .rebel:
                return UIColor.whiteSmoke
            default:
                return UIColor.white
            }
        }
    }
    
    static var secondaryColor: UIColor {
        get {
            switch currentTheme {
            case .rebel:
                return UIColor.mako
            default:
                return UIColor.black
            }
        }
    }
    
    static var detailColor: UIColor {
        get {
            switch currentTheme {
            case .rebel:
                return UIColor.persimmon
            default:
                return UIColor.orange
            }
        }
    }
}
