//
//  Utilities.swift
//  Encrypter
//
//  Created by Trip Creighton on 1/28/17.
//  Copyright © 2017 Trip Creighton. All rights reserved.
//

import Foundation
import UIKit

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
    
    func base64Encode() -> String {
        return (self.data(using: String.Encoding.utf8)?.base64EncodedString())!
    }
    
    func base64Decode() -> String {
        return String(data: Data(base64Encoded: self)!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
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
    
    func isAlpha() -> Bool{
        let lower = "abcdefghijklmnopqrstuvwxyz"
        let upper = "ABDEFGHIJKLMNOPQRSTUV"
        return lower.contains(String(self)) || upper.contains(String(self))
    }
}
