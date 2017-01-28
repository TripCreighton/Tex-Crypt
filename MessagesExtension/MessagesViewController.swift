//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Trip Creighton on 1/25/17.
//  Copyright © 2017 Trip Creighton. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    @IBOutlet var textfield: UITextField!
    var convo:MSConversation!
    
    @IBAction func someSwitch(_ sender: UISwitch) {
        textfield.text = rot(textfield.text!, back: sender.isOn, rotLen: 13)
        sendText(textfield.text!)
    }
    
    func rot(_ enc: String, back: Bool,  rotLen: UInt32) -> String {
        if rotLen < 0 {
            return ""
        }
        var encrypted:String = ""
        for char in enc.array() {
            if char == " " {
                encrypted.append(" ")
                continue
            }
            if !back {
                encrypted.append(Character(UnicodeScalar(char.toAscii() + rotLen)!))
            } else {
                encrypted.append(Character(UnicodeScalar(char.toAscii() - rotLen)!))
            }
        }
        return encrypted
    }
    
    func sendText(_ msg: String!) {
        self.activeConversation?.insertText(msg, completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convo = self.activeConversation
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


extension String {
    
    var count:Int {
        return self.characters.count
    }
    
    func array() -> [Character] {
        var arr:[Character]! = []
        for char in self.characters {
            arr.append(char)
        }
        return arr
    }
    
    func at(_ pos: Int) -> Character? {
        if self.characters.count < pos {
            return nil
        }
        return self.array()[pos]
    }
}


extension UIWebView {
    func parseAndLoad(_ query: String) {
        if query.contains(" ") {
            self.loadRequest(URLRequest(url: URL(string: "https://www.google.com/?q=\(query.replacingOccurrences(of: " ", with: "+"))")!))
        } else {
            self.loadRequest(URLRequest(url: URL(string: query)!))
        }
    }
}

extension UIColor {
    convenience init?(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension Character {
    func toAscii() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}
