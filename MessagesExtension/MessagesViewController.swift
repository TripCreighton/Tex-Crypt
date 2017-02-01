//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Trip Creighton on 1/25/17.
//  Copyright © 2017 Trip Creighton. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, UITextFieldDelegate {
    @IBOutlet var messageLabel: UILabel!,
                  textfield: UITextField!
    
    private var rotLength:Int = 13,
                encryptedText:String!
    
    @IBAction func copyMessageButton(_ sender: UIButton) {
        if encryptedText == nil {
            //Error
            return
        }
        self.activeConversation?.insertText(encryptedText, completionHandler: nil)
    }
    
    func rot(_ enc: String, back: Bool,  rotLen: UInt32) -> String {
        if rotLen < 0 || rotLen > 26 {
            return ""
        }
        var encrypted:String = ""
        for char in enc.lowercased().array() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update() {
        messageLabel.text = "Message: " + rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
        encryptedText = rot(textfield.text!, back: false, rotLen: UInt32(rotLength))
        messageLabel.sizeToFit()
    }
    
    // MARK: - Custom overrides
   
    @IBAction func didEditingEnd(_ sender: Any) {
        update()
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        
    }
    
    override func didResignActive(with conversation: MSConversation) {

    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
    
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
    
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
    
    }

}
