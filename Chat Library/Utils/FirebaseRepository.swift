//
//  FirebaseRepository.swift
//  Chat Library
//
//  Created by Omar on 1/5/22.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class FirebaseRepository {
    private let firestore = Firebase.Firestore.firestore()
    private let storage = Storage.storage().reference()

    func getMessages(roomId: String, onFinish: @escaping ([ChatModel]?, String?) -> Void) {
        firestore.collection(ChatMessagesKey).document(REPLACEMENT_CHAT).collection(roomId).order(by: MESSAGE_TIME, descending: false).addSnapshotListener { (snapShot, error) in
            if (snapShot != nil) {
                var messages = [ChatModel]()
                for message in snapShot!.documents {
                    let chatModel = ChatModel()
                    chatModel.messageId = message.documentID
                    chatModel.senderId = message[SENDER_ID] as! String
                    chatModel.receiverId = message[RECEIVER_ID] as! String
                    chatModel.message = message[MESSAGE] as! String
                    chatModel.time = message[MESSAGE_TIME] as? Timestamp
                    chatModel.type = message[MESSAGE_TYPE] as! String
                    chatModel.uri = message[MESSAGE_URI] as? String
                    chatModel.messageStatus = message[MESSAGE_STATUS] as! String
                    messages.append(chatModel)
                }
                 
                onFinish(messages, nil)
            } else {
                onFinish(nil, error?.localizedDescription)
            }
        }
    }

    func sendMessage(chatModel: ChatModel, roomId: String) {
        chatModel.messageStatus = ChatModel.MessageStatus.NOT_SENT.rawValue
        firestore.collection(ChatMessagesKey).document(REPLACEMENT_CHAT).collection(roomId).document().setData(chatModel.getHashable()) { (error) in
            if (error != nil) {
                let messages = [chatModel]
                let docData = [ChatMessagesKey: messages]
                self.firestore.collection(ChatMessagesKey).document(roomId).setData(docData)
            }
        }
    }

    func updateSeenStatus(chatList: [ChatModel], roomId: String) {
        for chatModel in chatList {
            firestore.collection(ChatMessagesKey).document(REPLACEMENT_CHAT).collection(roomId).document(chatModel.messageId).updateData([MESSAGE_STATUS: chatModel.messageStatus])
        }
    }

    func saveImage(id: String, image: UIImage, onProgress: @escaping (Double) -> Void, onFinish: @escaping (String?, String?) -> Void) {
        let fireReference = storage.child("ChatImages").child("\(id).jpg")
        let uploadTask = fireReference.putData(image.jpegData(compressionQuality: 0.5)!, metadata: nil) { (metadata, error) in

        }

        let _ = uploadTask.observe(.progress) { (snapShot) in
            onProgress(snapShot.progress!.fractionCompleted * 100)
        }

        let _ = uploadTask.observe(.success) { (snapShot) in
            fireReference.downloadURL { (url, error) in
                onFinish(url?.absoluteString, error?.localizedDescription)
            }
        }

        let _ = uploadTask.observe(.failure) { (snapShot) in
            onFinish(nil, snapShot.error?.localizedDescription)
        }
    }
}
