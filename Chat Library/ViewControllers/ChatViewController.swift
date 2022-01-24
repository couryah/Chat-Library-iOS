//
//  ChatViewController.swift
//  Chat Library
//
//  Created by Omar on 1/3/22.
//

import UIKit
import FirebaseFirestore

public class ChatViewController: UIViewController {
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var messagesTableView: UITableView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    public var user1: ChatUserModel?
    public var user2: ChatUserModel?
    
    public var orderId: String?
    fileprivate var chatMessages = [ChatModel]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
        
        title = "Order No #\(orderId ?? "")"
        initSendButton()
        initTableView()
        loadMessages()
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
         guard let userInfo = notification.userInfo else { return }

         let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
         let endFrameY = endFrame?.origin.y ?? 0
         let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
         let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
         let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
         let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

         if endFrameY >= UIScreen.main.bounds.size.height {
           self.bottomConstraint?.constant = 8.0
         } else {
             self.bottomConstraint?.constant = endFrame?.size.height ?? 0.0 + 8.0
         }

         UIView.animate(
           withDuration: duration,
           delay: TimeInterval(0),
           options: animationCurve,
           animations: { self.view.layoutIfNeeded() },
           completion: nil)
       }
    
    fileprivate func initSendButton() {
        sendButton.backgroundColor = UIColor.themeColor
        sendButton.layer.cornerRadius = 23
    }
    
    fileprivate func initTableView() {
        messagesTableView.register(UINib(nibName: "SenderTextTableViewCell", bundle: LibraryBundle), forCellReuseIdentifier: SenderTextTableViewCell.getIdentifier())
        
        messagesTableView.register(UINib(nibName: "ReceiverTextTableViewCell", bundle: LibraryBundle), forCellReuseIdentifier: ReceiverTextTableViewCell.getIdentifier())
    }
    
    fileprivate func loadMessages() {
        FirebaseRepository().getMessages(roomId: orderId!) { (chatList, error) in
            if (error != nil) {
                
            } else {
                self.chatMessages = chatList!
                self.messagesTableView.reloadData()
                self.setMessagesAsSeen()
                self.scrollToBottom()
            }
        }
    }
    
    fileprivate func setMessagesAsSeen() {
        var messagesToUpdate = [ChatModel]()
        for chatMessage in chatMessages {
            let senderId = user1!.isSender ? user1?.id : user2?.id
            if (chatMessage.senderId != senderId && !chatMessage.hasBeenSeen()) {
                chatMessage.messageStatus = ChatModel.MessageStatus.RECEIVED.rawValue
                messagesToUpdate.append(chatMessage)
            }
        }
        
        FirebaseRepository().updateSeenStatus(chatList: messagesToUpdate, roomId: orderId!)
    }
    
    @IBAction func onSendButtonClicked(_ sender: Any) {
        if (!messageTextField.text!.isEmpty) {
            let chatMessage = createMessage(text: messageTextField.text!, messageType: ChatModel.MessageType.TEXT.rawValue, imageUri: nil)
            
            chatMessages.append(chatMessage)
            messagesTableView.reloadData()
            scrollToBottom()
            FirebaseRepository().sendMessage(chatModel: chatMessage, roomId: orderId!)
            messageTextField.text = ""
        }
    }
    
    fileprivate func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatMessages.count-1, section: 0)
            self.messagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    fileprivate func createMessage(text: String, messageType: String, imageUri: String?) -> ChatModel {
        var senderId = ""
        var receiverId = ""
        if (user2!.isSender) {
            senderId = user2!.id
            receiverId = user1!.id
        } else {
            senderId = user1!.id
            receiverId = user2!.id
        }
        return ChatModel(senderId: senderId, receiverId: receiverId, message: text, time: Timestamp(), type: messageType, uri: imageUri, messageStatus: ChatModel.MessageStatus.NOT_SENT.rawValue)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatMessages[indexPath.row]
        let senderId = user1!.isSender ? user1?.id : user2?.id
        
        let reusableIdentifier = message.senderId == senderId ? SenderTextTableViewCell.getIdentifier() : ReceiverTextTableViewCell.getIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as! TextTableViewCell
        cell.messageLabel.text = message.message
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        cell.timeLabel.text = dateFormatter.string(from: (message.time?.dateValue())!)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
