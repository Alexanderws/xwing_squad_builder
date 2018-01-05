//
//  BackgroundFilterView.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 15/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class BackgroundFilterView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.alpha = 0.85
        self.backgroundColor = ColorManager.secondaryColor
        
    }
}
