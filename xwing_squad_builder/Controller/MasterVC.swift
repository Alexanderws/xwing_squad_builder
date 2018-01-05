//
//  MasterVC.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 15/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    
    private var squadListVC: SquadListVC!
    private var squadViewerVC: SquadViewerVC!
    private var squadPilotVC: SquadPilotVC!
    
    private var squadList: [Squad]?
    private var selectedSquad: Squad?
    
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
        squadListVC = SquadListVC(nibName: "SquadListVC", bundle: nil, withDelegate: self)
        ViewManager.add(asChildViewController: squadListVC, inView: containerView, fromViewController: self, atLevel: 2)
    }

    
    
    
}

extension MasterVC: SquadListVCDelegate {
    
    func showSquadViewer(withSquad: Squad) {
        self.selectedSquad = withSquad
        squadViewerVC = SquadViewerVC(nibName: "SquadViewerVC", bundle: nil, withSquad: withSquad, withDelegate: self)
        ViewManager.add(asChildViewController: squadViewerVC, inView: containerView, fromViewController: self, atLevel: 3)
    }
}

extension MasterVC: SquadViewerVCDelegate {
    func showSquadPilot(withSquadPilot: SquadPilot) {
        squadPilotVC = SquadPilotVC(nibName: "SquadPilotVC", bundle: nil, withPilot: withSquadPilot, withDelegate: self)
        ViewManager.add(asChildViewController: squadPilotVC, inView: containerView, fromViewController: self, atLevel: 4)
    }
    

    func closeSquadViewer() {
        ViewManager.remove(asChildViewController: squadViewerVC)
    }
}

extension MasterVC: SquadPilotVCDelegate {

    func getSelectedSquad() -> Squad? {
        if let squad = self.selectedSquad {
            return squad
        }
        return nil
    }
    
    func closeSquadPilot() {
        ViewManager.remove(asChildViewController: squadPilotVC)
    }
    
}
