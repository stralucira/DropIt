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
            UIColor(red: 0.9, green: 0.5, blue: 0.3, alpha: 1).setStroke()
            UIColor(red: 0.9, green: 0.5, blue: 0.3, alpha: 1).setFill()
            path.stroke()
            path.fill()
        }
    }
    
    var bezierPaths = [String:UIBezierPath]() {
        didSet {
            setNeedsDisplay()
        }
    }

}
