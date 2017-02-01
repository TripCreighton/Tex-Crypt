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
    
    //Rotates
    func rot(_ str: String, back: Bool,  rotLen: UInt32) -> String {
        if rotLen < 0 || rotLen > 26 {
            return ""
        }
        var encrypted:String = ""
        for char in str.lowercased().array() {
            if !char.isAlpha() {
                encrypted.append(char)
                continue
            }
            if !back {
                if char.toAscii() + rotLen > 122 {
                    encrypted.append(Character(UnicodeScalar(char.toAscii() - rotLen)!))
                    continue
                }
                encrypted.append(Character(UnicodeScalar(char.toAscii() + rotLen)!))
            } else {
                if char.toAscii() - rotLen < 97 {
                    encrypted.append(Character(UnicodeScalar(char.toAscii() + rotLen)!))
                    continue
                }
                encrypted.append(Character(UnicodeScalar(char.toAscii() - rotLen)!))
            }
        }
        return encrypted
    }
    
    // MARK: - Custom overrides
   
    @IBAction func didEditingEnd(_ sender: Any) {
        textView.text = rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
        message = rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}
