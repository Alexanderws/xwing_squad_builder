//
//  SquadListVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 08/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit
import CoreData

protocol SquadListVCDelegate: class {
    
    func showSquadViewer(withSquad: Squad)
    
}

class SquadListVC: UIViewController {
    
    
    @IBOutlet weak var squadListCV: UICollectionView!
    
    var squadCreateVC: SquadCreateVC!
    var squadViewerVC: SquadViewerVC!
    var squadList: [Squad]! // TODO: Initialize from stored data

    private var squadListVCDelegate: SquadListVCDelegate!
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withDelegate: SquadListVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.squadListVCDelegate = withDelegate
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
        initSquadList()
        initShipPilotData()
    }
    
    func initSquadList() {
        squadListCV.dataSource = self
        squadListCV.delegate = self
        squadListCV.register(UINib(nibName: "SquadCell", bundle: nil), forCellWithReuseIdentifier: "SquadCell")
        if squadList == nil {
            self.squadList = [Squad]()
        }
    }
    
    func initShipPilotData() {
        ShipManager.initShips()
        PilotManager.initPilots()
        UpgradeManager.initUpgrades()
    }
    
    
    func refreshSquadList() {
        squadListCV.reloadData()
    }

    func presentSquadCreateVC() {
        squadCreateVC = SquadCreateVC(nibName: "SquadCreateVC", bundle: nil)
        squadCreateVC.squadCreateDelegate = self
        squadCreateVC.modalPresentationStyle = .custom
        self.present(squadCreateVC, animated: true, completion: nil)
    }
    
    // TODO: Clean up
    /*func presentSquadViewerVC(withSquad: Squad) {
        squadViewerVC = SquadViewerVC(nibName: "SquadViewerVC", bundle: nil)
        squadViewerVC.squadViewerDelegate = self
        squadViewerVC.currentSquad = withSquad
        squadViewerVC.modalPresentationStyle = .custom
        self.present(squadViewerVC, animated: true, completion: nil)
    }*/
    
    
    @IBAction func newSquadBtnPressed(_ sender: Any) {
        presentSquadCreateVC()
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
    
    }
    
}


extension SquadListVC: SquadCreateVCDelegate {
    
    func createSquad(fromSquad: Squad) {
        squadList.append(fromSquad)
        dismiss(animated: false, completion: nil)
        squadListVCDelegate?.showSquadViewer(withSquad: fromSquad)
    }
    
    func cancelSquadCreation() {
        dismiss(animated: true, completion: nil)
    }
}


/*extension SquadListVC: SquadViewerVCDelegate {
    func showSquadPilot(withSquadPilot: SquadPilot) {
        
    }
    
    
    func closeSquadViewer() {
        dismiss(animated: true, completion: nil)
        refreshSquadList()
    }
}*/


extension SquadListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squadList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquadCell", for: indexPath) as! SquadCell
        let squad = squadList[indexPath.row]
        squadCell.initUI(squadName: squad.name, squadCost: squad.squadCost)
        return squadCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 130
        let width = Int(self.view.frame.size.width) - 16
        return CGSize(width: width, height: height)
    }

}
