//
//  ModalSelectionSearchRemove.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit



class ModalSelectionSearchRemoveVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var selectionTableView: UITableView!
    
    
    var modalSelectionVCDelegate: ModalSelectionVCDelegate!
    
    var selectedFaction: Faction!
    var selectionType: SelectionType!
    
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withFaction: Faction, withSelectionType: SelectionType, selectionDelegate: ModalSelectionVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedFaction = withFaction
        self.selectionType = withSelectionType
        self.modalSelectionVCDelegate = selectionDelegate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func removeBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func clearBtnPressed(_ sender: UIButton) {
    }
    

}
