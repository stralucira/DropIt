//
//  DropItViewController.swift
//  DropIt
//
//  Created by Başar Oğuz on 26/01/17.
//  Copyright © 2017 basaroguz. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController {

    
    @IBOutlet weak var gameView: DropItView!{
        
        didSet{
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DropItViewController.addDrop(_:))))
        }
    }
    
    @objc
    func addDrop(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            gameView.addDrop()
        }
    }


}
