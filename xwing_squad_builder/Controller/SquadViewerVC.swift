//
//  SquadViewerVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit
import Foundation

protocol SquadViewerVCDelegate: class {
    
    func showSquadPilot(withSquadPilot: SquadPilot)

    func closeSquadViewer()    
}


class SquadViewerVC: UIViewController {
    
    @IBOutlet weak var squadNameLbl: UILabel!
    @IBOutlet weak var squadCostLbl: UILabel!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var agilityValueLbl: UILabel!
    @IBOutlet weak var shieldHullValueLbl: UILabel!
    @IBOutlet weak var winPercentageLbl: UILabel!
    @IBOutlet weak var timesPlayedLbl: UILabel!
    @IBOutlet weak var squadPilotsCV: UICollectionView!
    
    
    
    var shipSelectVC: ModalSelectionVC!
    var pilotSelectVC: ModalSelectionVC!
    var currentSquad: Squad!
    var squadViewerDelegate: SquadViewerVCDelegate!
    private var selectedShip: Ship!
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withSquad: Squad, withDelegate: SquadViewerVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.currentSquad = withSquad
        self.squadViewerDelegate = withDelegate
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
    
    override func viewWillAppear(_ animated: Bool) {
        initSquadPilots()
        updateUI()
    }

    func initSquadPilots() {
        squadPilotsCV.dataSource = self
        squadPilotsCV.delegate = self
        squadPilotsCV.register(UINib(nibName: "SquadPilotCell", bundle: nil), forCellWithReuseIdentifier: "SquadPilotCell")
    }
    
    func updateUI() {
        squadNameLbl.text = currentSquad.name
        squadCostLbl.text = "\(currentSquad.squadCost)/\(currentSquad.squadCostLimit!)"
        attackValueLbl.text = "\(currentSquad.attackValue)"
        agilityValueLbl.text = "\(currentSquad.agilityValue)"
        shieldHullValueLbl.text = "\(currentSquad.shieldHullValue)"
        winPercentageLbl.text = "\(currentSquad.winPercentage)%"
        timesPlayedLbl.text = "\(currentSquad.timesPlayed)"
    }
    
    @objc func deletePressed(_ sender: UIButton) {
        guard let cell = LayoutManager.getCell(for: sender) as? SquadPilotCell else {
            fatalError("Could not get cell")
        }
        cell.resetPosition()
        guard let index = squadPilotsCV.indexPath(for: cell) else {
            fatalError("Could not get indexPath")
        }
        currentSquad.remove(pilot: index.row)
        DispatchQueue.main.async {
            self.squadPilotsCV.deleteItems(at: [index])
        }
        updateUI()
    }
    
    @objc func copyPressed(_ sender: UIButton) {
        
    }
    
    func presentShipSelectVC(withFaction: Faction) {
        shipSelectVC = ModalSelectionVC(nibName: "ModalSelectionVC", bundle: nil, withFaction: withFaction, withSelectionType: SelectionType.ship, selectionDelegate: self)
        ViewManager.add(asChildViewController: shipSelectVC, inView: self.view, fromViewController: self, atLevel: 6)
    }
    
    func transitionShipToPilotVC(withFaction: Faction) {
        pilotSelectVC = ModalSelectionVC(nibName: "ModalSelectionVC", bundle: nil, withFaction: withFaction, withSelectionType: SelectionType.pilot, selectionDelegate: self)
        ViewManager.add(asChildViewController: pilotSelectVC, inView: self.view, fromViewController: self, atLevel: 7)
    }
    
    @IBAction func draggableBtnPressed(_ sender: Any) {
        squadViewerDelegate?.closeSquadViewer()
    }
    
    
    @IBAction func plusBtnPressed(_ sender: Any) {
        presentShipSelectVC(withFaction: currentSquad.faction)
    }
    
    @IBAction func gearBtnPressed(_ sender: Any) {
    
    }
    
}

// MARK: - ShipSelectVCDelegate Methods
extension SquadViewerVC: ModalSelectionVCDelegate {
        
    func getSelectedShip() -> Ship {
        return selectedShip
    }
    
    func didSelect(ship: Ship, withFaction: Faction) {
        selectedShip = ship
        transitionShipToPilotVC(withFaction: currentSquad.faction)
    }
    
    func didSelect(pilot: Pilot) {
        let newSquadPilot = SquadPilot(fromPilot: pilot)
        currentSquad.add(pilot: newSquadPilot)
        ViewManager.remove(asChildViewController: shipSelectVC)
        ViewManager.remove(asChildViewController: pilotSelectVC)
        DispatchQueue.main.async {
            self.squadPilotsCV.insertItems(at: [IndexPath(row: self.currentSquad.pilots.count - 1, section: 0)])
        }
        updateUI()
    }
    
    func cancelPressed(senderType: SelectionType) {
        if senderType == .ship {
            ViewManager.remove(asChildViewController: shipSelectVC)
        }
        if senderType == .pilot {
            ViewManager.remove(asChildViewController: pilotSelectVC)
        }
    }
}


// MARK: - UICollectionView Methods
extension SquadViewerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSquad.pilots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadPilotCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquadPilotCell", for: indexPath) as! SquadPilotCell
        let pilot = currentSquad.pilots[indexPath.row]
        
        squadPilotCell.deleteBtn.addTarget(self, action: #selector(self.deletePressed(_:)), for: .touchUpInside)
        squadPilotCell.copyBtn.addTarget(self, action: #selector(self.copyPressed(_:)), for: .touchUpInside)

        squadPilotCell.initUI(pilot: pilot)
        return squadPilotCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var rows = Double(currentSquad.pilots[indexPath.row].upgradeStrings.count) / 2
        rows = rows.rounded()
        var height = 56
        if let cell = collectionView.cellForItem(at: indexPath) as? SquadPilotCell {
            height += Int(cell.upgradesCV.contentSize.height)
            print("Cell generated!!!!")
        }
        let width = Int(UIScreen.main.bounds.size.width) + 190
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SquadPilotCell
        if !cell.isPanned {
        let selectedSquadPilot = currentSquad.pilots[indexPath.row]
            squadViewerDelegate?.showSquadPilot(withSquadPilot: selectedSquadPilot)
        }
    }

    
}
