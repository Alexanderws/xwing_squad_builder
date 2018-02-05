//
//  UpgradeCell.swift
//  xwing_squad_builder
//
//  Created by Alexander on 29/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class UpgradeCell: UICollectionViewCell {

    @IBOutlet weak var upgradeUniqueIV: UIImageView!
    @IBOutlet weak var upgradeNameLbl: UILabel!
    @IBOutlet weak var upgradeSquadCostLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var upgradeTextLbl: UILabel!
    @IBOutlet weak var firstUpgradeIconIV: UIImageView!
    @IBOutlet weak var secondUpgradeIconIV: UIImageView!
    @IBOutlet weak var upgradeRestrictionLbl: UILabel!
    @IBOutlet weak var attackValueIV: UIImageView!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var attackRangeIV: UIImageView!
    @IBOutlet weak var attackRangeLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint.constant = LayoutManager.collectionViewWidth
    }

    func initUI(fromUpgradeVM: UpgradeVM) {
        upgradeUniqueIV.isHidden = !fromUpgradeVM.isUnique
        upgradeNameLbl.text = fromUpgradeVM.name
        upgradeSquadCostLbl.text = String(fromUpgradeVM.squadCost)
        upgradeTextLbl.text = fromUpgradeVM.text
        if !fromUpgradeVM.isWeapon {
            attackValueIV.isHidden = true
            attackValueLbl.isHidden = true
            attackRangeIV.isHidden = true
            attackRangeLbl.isHidden = true
        } else {
            attackValueLbl.text = String(fromUpgradeVM.attackValue)
            attackRangeLbl.text = fromUpgradeVM.attackRange
        }
        self.upgradeRestrictionLbl.text = fromUpgradeVM.restrictionText
        self.firstUpgradeIconIV.image = UIImage(named: "\(fromUpgradeVM.imageNameWhite)")
        if fromUpgradeVM.slotCount < 2 {
            self.secondUpgradeIconIV.isHidden = true
        } else {
            self.secondUpgradeIconIV.image = UIImage(named: "\(fromUpgradeVM.imageNameWhite)")
        }
    }
    
    func initUI(fromUpgrade: Upgrade) {
        upgradeUniqueIV.isHidden = !fromUpgrade.isUnique
        upgradeNameLbl.text = fromUpgrade.name
        upgradeSquadCostLbl.text = String(fromUpgrade.squadCost)
        upgradeTextLbl.text = fromUpgrade.text
        if !fromUpgrade.isWeapon {
            attackValueIV.isHidden = true
            attackValueLbl.isHidden = true
            attackRangeIV.isHidden = true
            attackRangeLbl.isHidden = true
        } else {
            attackValueLbl.text = String(fromUpgrade.attackValue)
            attackRangeLbl.text = fromUpgrade.range
        }
    }
    
    
}
