//
//  DropItViewController.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gameView.animating = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        gameView.animating = false
    }
    
    
    @IBOutlet weak var gameView: DropItView!{
        didSet{
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DropItViewController.addDrop(_:))))
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(DropItView.grapDrop(recognizer:))))
        }
    } 
    
    @objc
    func addDrop(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }


}
