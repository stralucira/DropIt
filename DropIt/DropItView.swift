//
//  DropItView.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class DropItView: NamedBezierPathsView, UIDynamicAnimatorDelegate {

    private let dropBehavior = FallingObjectBehavior()
    
    private lazy var animator: UIDynamicAnimator = {
        let _animator = UIDynamicAnimator(referenceView: self)
        _animator.delegate = self
        return _animator
    }()
    
    var animating: Bool = false {
        didSet {
            if animating {
                animator.addBehavior(dropBehavior)
            } else {
                animator.removeBehavior(dropBehavior)
            }
        }
    }
    
    struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
    }
    
    private var attachment: UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
                bezierPaths["Attachment"] = nil
            }
        }
        
        didSet{
            if attachment != nil {
                animator.addBehavior(attachment!)
                attachment!.action = {
                    [unowned self] in
                    
                    if let attachedDrop = self.attachment!.items.first as? UIView {
                        self.bezierPaths["Attachment"] = UIBezierPath.lineFrom(from: self.attachment!.anchorPoint, to: attachedDrop.center)
                    }
                }
            }
        }
    }
    
    private var lastDrop: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(ovalIn: CGRect(center: bounds.mid, size: dropSize))
        dropBehavior.addBarrier(path: path, name: PathNames.MiddleBarrier)
        
        bezierPaths[PathNames.MiddleBarrier] = path
        
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    func grapDrop(recognizer: UIPanGestureRecognizer) {
        let gesturePoint = recognizer.location(in: self)
        
        switch recognizer.state {
            
        case .began:
            //Create the attachment.
            if let dropToAttachTo = lastDrop, dropToAttachTo.superview != nil {
                attachment = UIAttachmentBehavior(item: dropToAttachTo, attachedToAnchor: gesturePoint)
                lastDrop = nil
            }
        case .changed:
            // Change the attachment anchor point.
            attachment?.anchorPoint = gesturePoint
        default:
            attachment = nil
        }
    }
    
    private func removeCompletedRow(){
        var dropsToRemove = [UIView]()
        
        var hitTestRect = CGRect(origin: bounds.lowerLeft, size: dropSize)
        
        repeat {
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            
            var dropsTested = 0
            var dropsFound = [UIView]()
            
            while dropsTested < dropsPerRow {
                if let hitView = hitTest(p: hitTestRect.mid) , hitView.superview == self {
                    dropsFound.append(hitView)
                } else {
                    break
                }
                hitTestRect.origin.x += dropSize.width
                dropsTested += 1
                
            }
            
            if dropsTested == dropsPerRow {
                dropsToRemove += dropsFound
            }
            
        } while (dropsToRemove.count == 0 && hitTestRect.origin.y > bounds.minY)
        
        for drop in dropsToRemove {
            dropBehavior.removeItem(item: drop)
            drop.removeFromSuperview()
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
        
        addSubview(drop)
        dropBehavior.addItem(item: drop)
        lastDrop = drop
    }
}
