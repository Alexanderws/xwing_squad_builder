//
//  SwipeCollectionViewCell.swift
//  xwing_squad_builder
//
//  Created by Alexander on 05/01/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation
import UIKit

class SwipeCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    private var panGesture: UIPanGestureRecognizer!
    private(set) var isPanned = false
    private(set) var cellWidth: CGFloat!
    private(set) var cellHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if panGesture.state == UIGestureRecognizerState.changed {
            let panTranslation: CGPoint = panGesture.translation(in: self)
            cellWidth = self.contentView.frame.width
            cellHeight = self.contentView.frame.height
            self.contentView.frame = CGRect(x: panTranslation.x,y: 0, width: cellWidth, height: cellHeight);
        }
    }
    
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.began {
            
        } else if pan.state == UIGestureRecognizerState.changed && panGesture.velocity(in: self).x < 0 && !isPanned{
            self.setNeedsLayout()
        } else if pan.state == UIGestureRecognizerState.ended && (panGesture.velocity(in: self).x < -500 || self.contentView.frame.minX < -80) {
            self.isPanned = true
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView.frame = CGRect(x: -160, y: 0, width: self.cellWidth, height: self.cellHeight)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.isPanned = false
                self.setNeedsLayout()
                self.layoutIfNeeded()
            })
        }
    }
    
    func resetPosition() {
        UIView.animate(withDuration: 0.3, animations: {
            self.isPanned = false
            self.setNeedsLayout()
            self.layoutIfNeeded()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false //abs(panGesture.velocity(in: self).x) < 50
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((panGesture.velocity(in: panGesture.view)).x) > abs((panGesture.velocity(in: panGesture.view)).y)
    }
    
    
}
