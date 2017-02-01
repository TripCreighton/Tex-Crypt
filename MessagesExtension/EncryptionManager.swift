//
//  EncryptionManager.swift
//  Tex-Crypt
//
//  Created by Trip Creighton on 1/31/17.
//  Copyright © 2017 Trip Creighton. All rights reserved.
//

import Foundation

/*
    This class contains all of the available encryption methods.
 */
class EncryptionManager {
    
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
    
    func base64(str: String, decode: Bool!) -> String {
        if !decode {
            return str.base64Encode()
        }
        return str.base64Decode()
    }
}
