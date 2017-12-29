//
//  SquadCell.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class SquadCell: UICollectionViewCell {

    @IBOutlet weak var factionLogoIV: UIImageView!
    @IBOutlet weak var squadNameLbl: UILabel!
    @IBOutlet weak var squadCostLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(squadName: String, squadCost: Int) {
        squadNameLbl.text = squadName
        squadCostLbl.text = "\(squadCost)"
    }
    
}
