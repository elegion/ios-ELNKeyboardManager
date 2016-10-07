//
//  ViewController.swift
//  Example
//
//  Created by Николай Кагала on 07/10/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit
import ELNKeyboardManager

class ViewController: UIViewController, ELNKeyboardManagerDelegate {
    
    var keyboardManager = ELNKeyboardManager()
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardManager.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        keyboardManager.enabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        keyboardManager.enabled = false
    }
    
    //MARK: ELNKeyboardManagerDelegate
    
    func keyboardManager(_ keyboardManager: ELNKeyboardManager, willChangeKeyboardFrameWithFrameBegin frameBegin: CGRect, frameEnd: CGRect) {
        let dY = frameBegin.origin.y - frameEnd.origin.y
        bottomConstraint.constant += dY
        self.view.layoutIfNeeded()
    }

}

