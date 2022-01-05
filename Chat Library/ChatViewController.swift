//
//  ChatViewController.swift
//  Chat Library
//
//  Created by Omar on 1/3/22.
//

import UIKit

public class ChatViewController: UIViewController {
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var messagesTableView: UITableView!
    
    var orderId: String = ""
    fileprivate var chatMessages = [ChatModel]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initSendButton()
        initTableView()
    }
    
    fileprivate func initSendButton() {
        sendButton.backgroundColor = UIColor.themeColor
        sendButton.layer.cornerRadius = 23
    }
    
    fileprivate func initTableView() {
        messagesTableView.register(SenderTextTableViewCell.self, forCellReuseIdentifier: SenderTextTableViewCell.getIdentifier())
    }
    
    fileprivate func loadMessages() {
        FirebaseRepository().getMessages(roomId: orderId) { (chatList, error) in
            if (error != nil) {
                
            } else {
                self.chatMessages = chatList!
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SenderTextTableViewCell.getIdentifier()) as! SenderTextTableViewCell
        
        let message = chatMessages[indexPath.row]
        cell.messageLabel.text = message.message
        cell.timeLabel.text = message.time
        
        return cell
    }
}
