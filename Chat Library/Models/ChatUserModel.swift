//
//  ChatUserModel.swift
//  Chat Library
//
//  Created by Omar on 19/01/2022.
//

import Foundation

public class ChatUserModel: NSObject, Codable, NSCoding {
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(firebaseNotificationToken, forKey: "firebaseNotificationToken")
        coder.encode(isSender, forKey: "isSender")
    }
    
    required convenience public init?(coder: NSCoder) {
        let id = coder.decodeObject(forKey: "id") as! String
        let name = coder.decodeObject(forKey: "name") as! String
        let firebaseNotificationToken = coder.decodeObject(forKey: "firebaseNotificationToken") as! String
        let isSender = coder.decodeBool(forKey: "isSender")
        self.init(id: id, name: name, firebaseNotificationToken: firebaseNotificationToken, isSender: isSender)
    }
    
    public init(id : String, name: String, firebaseNotificationToken: String, isSender: Bool) {
        self.id = id
        self.name = name
        self.firebaseNotificationToken = firebaseNotificationToken
        self.isSender = isSender
    }
    
    var id = ""
    var name = ""
    var firebaseNotificationToken = ""
    var isSender = false
    
    private enum CodingKeys : String, CodingKey {
        case id, name, firebaseNotificationToken, isSender
    }
}
