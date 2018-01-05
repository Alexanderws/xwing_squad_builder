//
//  SquadCreateVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//


protocol SquadCreateVCDelegate: class {
    func createSquad(fromSquad: Squad)
    func cancelSquadCreation()
}

import UIKit

class SquadCreateVC: UIViewController {
    
    
    @IBOutlet weak var squadNameTF: UITextField!
    @IBOutlet weak var squadCostTF: UITextField!
    
    
    var squadCreateDelegate: SquadCreateVCDelegate?
    var selectedFaction = Faction.mixed

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        squadNameTF.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func checkInputs() -> Bool {
        if !squadNameTF.hasText {
            ViewManager.displayMessage(title: "No Name Entered", message: "Enter a name for your new squad.", actionName: "Dismiss", viewController: self)
            return false
        }
        return true
    }
    
    func createSquad() -> Squad {
        let squadName = squadNameTF.text!
        let squadCost = Int(squadCostTF.text!)
        let newSquad = Squad(squadName: squadName, squadFaction: selectedFaction, squadCostLimit: squadCost!)
        return newSquad
    }
    
    @IBAction func squadCostBtnPressed(_ sender: UIButton) {
        if let value = Int(squadCostTF.text!) {
            if sender.tag == 0 && value > 0 {
                squadCostTF.text = String(value - 1)
            }
            if sender.tag == 1 && value < 1000 {
                squadCostTF.text = String(value + 1)
            }
        }
    }
    
    @IBAction func factionBtnPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedFaction = .rebelAlliance
        case 1:
            selectedFaction = .galacticEmpire
        case 2:
            selectedFaction = .scumAndVillainy
        case 3:
            selectedFaction = .mixed
        default:
            selectedFaction = .mixed
        }
        // TODO: Update button logos to highlight selected faction
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        squadCreateDelegate?.cancelSquadCreation()
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        if checkInputs() {
            let newSquad = createSquad()
            squadCreateDelegate?.createSquad(fromSquad: newSquad)
        }
    }
}

extension SquadCreateVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
}
