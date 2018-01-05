//
//  ShipCell.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 13/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class ShipCell: UITableViewCell {

    
    @IBOutlet weak var shipLogoIV: UIImageView!
    @IBOutlet weak var shipNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func initUI(shipName: String) {
        shipNameLbl.text = shipName
    }
    
}
