//
//  SquadViewerVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

protocol SquadViewerVCDelegate: class {
    
    func showSquadPilot(withSquadPilot: SquadPilot)

    func closeSquadViewer()    
}


class SquadViewerVC: UIViewController {

    
    @IBOutlet weak var squadNameLbl: UILabel!
    @IBOutlet weak var squadCostLbl: UILabel!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var shieldHullValueLbl: UILabel!
    @IBOutlet weak var winPercentageLbl: UILabel!
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
        refreshSquadView()
    }

    func initSquadPilots() {
        squadPilotsCV.dataSource = self
        squadPilotsCV.delegate = self
        squadPilotsCV.register(UINib(nibName: "SquadPilotCell", bundle: nil), forCellWithReuseIdentifier: "SquadPilotCell")
    }
    
    func refreshSquadView() {
        squadNameLbl.text = currentSquad.name
        squadCostLbl.text = "\(currentSquad.squadCost)/\(currentSquad.squadCostLimit!)"
        attackValueLbl.text = "ATT: \(currentSquad.attackValue)"
        shieldHullValueLbl.text = "S/H: \(currentSquad.shieldHullValue)"
        winPercentageLbl.text = "WIN: \(currentSquad.winPercentage)%"
    }
    
    func presentShipSelectVC(withFaction: Faction) {
        shipSelectVC = ModalSelectionVC(nibName: "ModalSelectionVC", bundle: nil, withFaction: withFaction, withSelectionType: SelectionType.ship, selectionDelegate: self)
        //shipSelectVC.modalPresentationStyle = .custom
        //self.present(shipSelectVC, animated: true, completion: nil)
        add(asChildViewController: shipSelectVC, atLevel: 4)
    }
    
    func transitionShipToPilotVC(withFaction: Faction) {
        pilotSelectVC = ModalSelectionVC(nibName: "ModalSelectionVC", bundle: nil, withFaction: withFaction, withSelectionType: SelectionType.pilot, selectionDelegate: self)
        //pilotSelectVC.modalPresentationStyle = .overCurrentContext
        //self.present(pilotSelectVC, animated: false, completion: nil)
        add(asChildViewController: pilotSelectVC, atLevel: 5)
    }
    
    private func add(asChildViewController viewController: UIViewController, atLevel: Int) {
        addChildViewController(viewController)
        view.insertSubview(viewController.view, at: atLevel)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
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

// MARK: ShipSelectVCDelegate extension
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
        currentSquad.addPilot(pilot: newSquadPilot)
        remove(asChildViewController: shipSelectVC)
        remove(asChildViewController: pilotSelectVC)
        squadPilotsCV.reloadData()
    }
    
    func cancelPressed(senderType: SelectionType) {
        if senderType == .ship {
            remove(asChildViewController: shipSelectVC)
        }
        if senderType == .pilot {
            remove(asChildViewController: pilotSelectVC)
        }
    }
}


extension SquadViewerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSquad.pilots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadPilotCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquadPilotCell", for: indexPath) as! SquadPilotCell
        let pilot = currentSquad.pilots[indexPath.row]
        squadPilotCell.configureCell(pilot: pilot)
        return squadPilotCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 56
        let width = Int(UIScreen.main.bounds.size.width) - 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSquadPilot = currentSquad.pilots[indexPath.row]
        squadViewerDelegate?.showSquadPilot(withSquadPilot: selectedSquadPilot)
    }
    
    
}
