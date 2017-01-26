//
//  Extensions.swift
//  DropIt
//
//  Created by CS193p Instructor.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor(red: 241/255, green: 203/255, blue: 1, alpha: 1)
        case 1: return UIColor(red: 1, green: 238/255, blue: 173/255, alpha: 1)
        case 2: return UIColor(red: 1, green: 111/255, blue: 105/255, alpha: 1)
        case 3: return UIColor(red: 1, green: 204/255, blue: 92/255, alpha: 1)
        case 4: return UIColor(red: 136/255, green: 216/255, blue: 176/255, alpha: 1)
        default: return UIColor.black
        }
    }
}

extension CGRect {
    var mid: CGPoint { return CGPoint(x: midX, y: midY) }
    var upperLeft: CGPoint { return CGPoint(x: minX, y: minY) }
    var lowerLeft: CGPoint { return CGPoint(x: minX, y: maxY) }
    var upperRight: CGPoint { return CGPoint(x: maxX, y: minY) }
    var lowerRight: CGPoint { return CGPoint(x: maxX, y: maxY) }
    
    init(center: CGPoint, size: CGSize) {
        let upperLeft = CGPoint(x: center.x-size.width/2, y: center.y-size.height/2)
        self.init(origin: upperLeft, size: size)
    }
}

extension UIView {
    func hitTest(p: CGPoint) -> UIView? {
        return hitTest(p, with: nil)
    }
}

extension UIBezierPath {
    class func lineFrom(from: CGPoint, to: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }
}
