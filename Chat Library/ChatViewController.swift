//
//  ChatViewController.swift
//  Chat Library
//
//  Created by Omar on 1/3/22.
//

import UIKit

public class ChatViewController: UIViewController {
    @IBOutlet var sendButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initSendButton()
    }
    
    fileprivate func initSendButton() {
        sendButton.backgroundColor = UIColor.themeColor
        sendButton.layer.cornerRadius = 23
//        sendButton.layer.borderColor = UIColor.themeColor.cgColor
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
