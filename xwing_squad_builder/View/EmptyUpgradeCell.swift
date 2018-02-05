//
//  EmptyUpgradeCell.swift
//  xwing_squad_builder
//
//  Created by Alexander on 29/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class EmptyUpgradeCell: UICollectionViewCell {

    @IBOutlet weak var upgradeTypeIV: UIImageView!
    @IBOutlet weak var upgradeTypeLbl: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint.constant = LayoutManager.collectionViewWidth
    }
    
    func initUI(withUpgradetype: String) {
        upgradeTypeIV.image = UIImage(named: AssetManager.getUpgradeIconName(from: withUpgradetype, color: "black"))
        upgradeTypeLbl.text = withUpgradetype.uppercased()
    }
}
