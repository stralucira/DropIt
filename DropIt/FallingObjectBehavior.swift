//
//  FallingObjectBehavior.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class FallingObjectBehavior: UIDynamicBehavior {

    private let gravity = UIGravityBehavior()
    
    private let collider: UICollisionBehavior = {
        let _collider = UICollisionBehavior()
        _collider.translatesReferenceBoundsIntoBoundary = true
        return _collider
    }()
    
    override init() {
        super.init()
        
        addChildBehavior(gravity)
        addChildBehavior(collider)
    }
    
    func addItem(item: UIDynamicItem) {
        
        gravity.addItem(item)
        collider.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem)
    {
        gravity.removeItem(item)
        collider.removeItem(item)
    }
    
}
