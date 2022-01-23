//
//  ChatModel.swift
//  Chat Library
//
//  Created by Omar on 1/5/22.
//

import FirebaseFirestore

class ChatModel: NSObject, Codable, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(senderId, forKey: "senderId")
        coder.encode(receiverId, forKey: "receiverId")
        coder.encode(message, forKey: "message")
        coder.encode(time?.dateValue, forKey: "time")
        coder.encode(type, forKey: "type")
        coder.encode(progress, forKey: "progress")
        coder.encode(uri, forKey: "uri")
        coder.encode(messageStatus, forKey: "messageStatus")
    }
    
    required convenience init?(coder: NSCoder) {
        let senderId = coder.decodeObject(forKey: "senderId") as! String
        let receiverId = coder.decodeObject(forKey: "receiverId") as! String
        let message = coder.decodeObject(forKey: "message") as! String
        let time = Timestamp(date: coder.decodeObject(forKey: "time") as! Date)
        let type = coder.decodeObject(forKey: "type") as! String
        let progress = coder.decodeDouble(forKey: "progress")
        let uri = coder.decodeObject(forKey: "uri") as! String
        let messageStatus = coder.decodeObject(forKey: "messageStatus") as! String
        self.init(senderId: senderId, receiverId: receiverId, message: message, time: time, type: type, progress: progress, uri: uri, messageStatus: messageStatus)
    }
    
    var senderId: String = ""
    var receiverId: String = ""
    var message: String = ""
    var time: Timestamp? = nil
    var type: String = ""
    var progress: Double = 0.0
    var uri: String? = nil
    var messageStatus: String = ""
    
    init(senderId : String, receiverId: String, message: String, time: Timestamp, type: String, progress: Double = 0.0, uri: String, messageStatus: String) {
        self.senderId = senderId
        self.receiverId = receiverId
        self.message = message
        self.time = time
        self.type = type
        self.progress = progress
        self.uri = uri
        self.messageStatus = messageStatus
    }
    
    init(dictionary: Dictionary<String, Any>) {
        self.senderId = dictionary["senderId"] as! String
        self.receiverId = dictionary["receiverId"] as! String
        self.message = dictionary["message"] as! String
        self.time = dictionary["time"] as? Timestamp
        self.type = dictionary["type"] as! String
        self.progress = dictionary["progress"] as! Double
        self.uri = dictionary["uri"] as? String
        self.messageStatus = dictionary["messageStatus"] as! String
    }
    
    private enum CodingKeys : String, CodingKey {
        case senderId, receiverId, message, time, type, progress, uri, messageStatus
    }
    
    enum MessageStatus : String {
        case NOT_SENT = "NOT_SENT", SENT = "SENT", RECEIVED = "RECEIVED"
    }
    
    func getHashable() -> [String: Any] {
        return ["senderId": senderId, "receiverId": receiverId, "message": message, "time": time!, "type": type, "progress": progress, "uri": uri, "messageStatus": messageStatus]
    }
}
