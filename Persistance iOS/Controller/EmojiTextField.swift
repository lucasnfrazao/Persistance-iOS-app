//
//  EmojiTextField.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 14/10/21.
//

import UIKit

class EmojiTextField: UITextField {

   // required for iOS 13
   override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
