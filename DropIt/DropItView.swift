//
//  DropItView.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class DropItView: UIView {

    private let dropBehavior = FallingObjectBehavior()
    
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    
    var animating: Bool = false {
        
        didSet {
            if animating {
                animator.addBehavior(dropBehavior)
            } else {
                animator.removeBehavior(dropBehavior)
            }
        }
        
    }
    
    
    private let dropsPerRow = 10
    
    private var dropSize: CGSize {
        let size = bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }

    func addDrop() {
        var frame = CGRect(origin: CGPoint.zero, size: dropSize)
        
        frame.origin.x = CGFloat.random(max: dropsPerRow) * dropSize.width
        
        let drop = UIView(frame: frame)
        drop.backgroundColor = UIColor.random
        
        print(drop.transform)
        
        addSubview(drop)
        dropBehavior.addItem(item: drop)
    }
}
