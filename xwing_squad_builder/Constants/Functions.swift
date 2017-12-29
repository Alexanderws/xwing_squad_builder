//
//  Functions.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import UIKit

func displayMessage(title: String, message: String, actionName: String, self: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: actionName, style: UIAlertActionStyle.cancel, handler: {
        (alertAction: UIAlertAction!) in
        alertController.dismiss(animated: true, completion: nil)
    }))
    self.present(alertController, animated: true, completion: nil)
}

func add(asChildViewController viewController: UIViewController, inView: UIView, fromViewController: UIViewController, atLevel: Int) {
    fromViewController.addChildViewController(viewController)
    inView.insertSubview(viewController.view, at: atLevel)
    viewController.view.frame = inView.bounds
    viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    viewController.didMove(toParentViewController: fromViewController)
}

func remove(asChildViewController viewController: UIViewController) {
    viewController.willMove(toParentViewController: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParentViewController()
}
