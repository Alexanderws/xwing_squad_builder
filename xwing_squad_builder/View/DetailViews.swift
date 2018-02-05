//
//  DetailViews.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 18/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class RaisedRoundView: UIView {
    
    var borderView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
    }
    

    
}


class DetailBtn: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setTitleColor(UIColor.persimmon, for: .normal)
    }
}

class SmallUpgradeView: UIView {
    var upgradeNameLbl: UILabel!
    var uniqueIV: UIImageView!
    
    private(set) var viewWidth: Int!
    private(set) var viewHeight: Int = 14
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init (name: String, isUnique: Bool) {
        self.init()
        upgradeNameLbl.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        upgradeNameLbl.text = name
        upgradeNameLbl.textColor = UIColor.black
        upgradeNameLbl.sizeToFit()
        if isUnique {
            uniqueIV = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 14))
            uniqueIV.image = UIImage(named: AssetManager.getUniqueIconName(color: "black"))
            uniqueIV.contentMode = .scaleAspectFit
            upgradeNameLbl = UILabel(frame: CGRect(x: 8, y: 0, width: upgradeNameLbl.frame.width, height: 14))
            viewWidth = 8 + Int(upgradeNameLbl.frame.width)
        } else {
            upgradeNameLbl = UILabel(frame: CGRect(x: 0, y: 0, width: upgradeNameLbl.frame.width, height: 14))
            viewWidth = Int(upgradeNameLbl.frame.width)
        }
    }
    
    
    
}

class DetailLbl: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.persimmon
    }
}

class PrimaryTextLbl: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.textColor = UIColor.white
    }
}


