//
//  DetailViews.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 18/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class DetailBtn: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setTitleColor(UIColor.persimmon, for: .normal)
    }
}

class DetailLbl: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.persimmon
    }
}

class PrimaryDarkView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.starDust
    }
}

class PrimaryDarkerView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.mako
    }
}




class PrimaryTextLbl: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
    }
}

class SecondaryTextLbl: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
    }
}

