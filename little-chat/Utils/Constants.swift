//
//  Constants.swift
//  little-chat
//
//  Created by Renzo Paul Chamorro on 20/11/21.
//

import Foundation

struct K {
    static let appName = "🍎LittleChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let green = "PrimaryColor"
        static let lightGreen = "LightPrimaryColor"
        static let darkGreen = "DarkPrimaryColor"
        static let yellow = "AccentColor"
        static let blackText = "PrimaryTextColor"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let usersCollection = "users"
        static let senderField = "sender"
        static let senderNickname = "nickname"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
