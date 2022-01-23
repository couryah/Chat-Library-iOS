//
//  ViewController.swift
//  Chat App
//
//  Created by Omar on 1/5/22.
//

import UIKit
import Chat_Library

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func openChat(isShopper: Bool) {
        let viewController = ChatViewController(nibName: "ChatViewController", bundle: Bundle(identifier: "couryah.Chat-Library"))
        let user1 = ChatUserModel(id: "CustomerId0101010101010", name: "Omar", firebaseNotificationToken: "", isSender: !isShopper)
        let user2 = ChatUserModel(id: "ShopperId01010101010101", name: "Ahmed", firebaseNotificationToken: "", isSender: isShopper)
        viewController.user1 = user1
        viewController.user2 = user2
        viewController.orderId = "8200"
        
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func onCustomerClicked(_ sender: Any) {
        openChat(isShopper: false)
    }
    
    @IBAction func onShopperClicked(_ sender: Any) {
        openChat(isShopper: true)
    }
}

