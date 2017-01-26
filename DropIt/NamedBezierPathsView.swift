//
//  NamedBezierPathsView.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class NamedBezierPathsView: UIView {

    override func draw(_ rect: CGRect) {
        for (_,path) in bezierPaths {
            path.stroke()
        }
    }
    
    var bezierPaths = [String:UIBezierPath]() {
        didSet {
            
            setNeedsDisplay()
        }
    }

}
