//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Trip Creighton on 1/25/17.
//  Copyright © 2017 Trip Creighton. All rights reserved.
//

import UIKit
import Messages

class MainVC: MSMessagesAppViewController, UITextFieldDelegate {
    @IBOutlet var textfield: UITextField!,
                  textView: UITextView!

    private var rotLength:Int = 13,
                message:String!
    
    private let encryptionManager = EncryptionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Text view
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        
        //Textfield
        textfield.layer.borderColor = UIColor.white.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 5
    }
    
    @IBAction func copyMessageButton(_ sender: UIButton) {
        if message == nil {
            //Error
            return
        }
        self.activeConversation?.insertText(message, completionHandler: nil)
    }
   
    @IBAction func didEditingEnd(_ sender: Any) {
        textView.text = encryptionManager.rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
        message = encryptionManager.rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}
