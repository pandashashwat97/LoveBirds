//
//  ViewController.swift
//  LoveBirds
//
//  Created by Shashwat Panda on 30/12/22.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
   
    @IBOutlet weak var loveLabel: CLTypingLabel!
    @IBOutlet weak var birdsLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loveLabel.charInterval = 0.15
        loveLabel.text = "LOVE"
        loveLabel.onTypingAnimationFinished = {
            self.birdsLabel.charInterval = 0.15
            self.birdsLabel.text = "BIRDS"
        }
    }
}

