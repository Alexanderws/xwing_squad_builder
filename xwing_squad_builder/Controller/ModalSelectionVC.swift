//
//  ModalSelectionVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

protocol ModalSelectionVCDelegate: class {
    func cancelPressed(senderType: SelectionType)
    func didSelect(ship: Ship, withFaction: Faction)
    func didSelect(pilot: Pilot)
    func getSelectedShip() -> Ship
}

// MARK: Used for Ships and Pilots
class ModalSelectionVC: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var selectionTableView: UITableView!
    
    var modalSelectionVCDelegate: ModalSelectionVCDelegate!
    //var shipsFRC: NSFetchedResultsController<Ships>?
    //var pilotsFRC: NSFetchedResultsController<Pilots>?
    
    var pilotList: Results<Pilot>?
    var shipList: Results<Ship>?

    
    var selectedFaction: Faction!
    var selectionType: SelectionType!
    var selectedShip: Ship!
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withFaction: Faction, withSelectionType: SelectionType, selectionDelegate: ModalSelectionVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedFaction = withFaction
        self.selectionType = withSelectionType
        self.modalSelectionVCDelegate = selectionDelegate
        if self.selectionType == .pilot {
            selectedShip = self.modalSelectionVCDelegate?.getSelectedShip()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initSelectionTableView()
        if selectionType == .ship {
            topLbl.text = "Ship"
        }
        if selectionType == .pilot {
            topLbl.text = "Pilot"
        }
    }
    
    override func viewWillLayoutSubviews() {
        initLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func initLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = true
        containerView.frame.size.height = ModalSelectionLayout.height
        containerView.frame.size.width = ModalSelectionLayout.width
        containerView.center.x = self.view.center.x
        containerView.center.y = self.view.center.y
    }
    
    func initSelectionTableView() {
        switch selectionType {
        case .ship:
            shipList = ShipManager.getShips(withFaction: selectedFaction)
            selectionTableView.register(UINib(nibName: "ShipCell", bundle: nil), forCellReuseIdentifier: "ShipCell")
        case .pilot:
            pilotList = PilotManager.getPilots(withFaction: selectedFaction, ofShip: selectedShip)
            selectionTableView.register(UINib(nibName: "PilotCell", bundle: nil), forCellReuseIdentifier: "PilotCell")
        default:
            return
        }
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
    }


    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        modalSelectionVCDelegate?.cancelPressed(senderType: selectionType)
    }
}

extension ModalSelectionVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectionType {
        case .ship:
            return shipList?.count ?? 0
        case .pilot:
            return pilotList?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectionType {
        case .ship:
            let cell = selectionTableView.dequeueReusableCell(withIdentifier: "ShipCell", for: indexPath) as! ShipCell
            if let ship = shipList?[indexPath.row] {
                cell.configureCell(shipName: ship.name)
            }
            return cell
        case .pilot: // TODO: Create pilot cell and initation function
            let cell = selectionTableView.dequeueReusableCell(withIdentifier: "PilotCell", for: indexPath) as! PilotCell
           if let pilot = pilotList?[indexPath.row] {
                cell.configureCell(pilot: pilot)
            }
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectionType == .ship {
           if let selectedShip = shipList?[indexPath.row] {
                modalSelectionVCDelegate?.didSelect(ship: selectedShip, withFaction: selectedFaction)
            }
        }
        if selectionType == .pilot {
            if let selectedPilot = pilotList?[indexPath.row] {
               modalSelectionVCDelegate?.didSelect(pilot: selectedPilot)
            }
        }
    }
}
