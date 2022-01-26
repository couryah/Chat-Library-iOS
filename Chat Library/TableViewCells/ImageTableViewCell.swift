//
//  ImageTableViewCell.swift
//  Chat Library
//
//  Created by Omar on 24/01/2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    
    var onImageClicked: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageViewTapGesture()
    }
    
    fileprivate func setImageViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openImage))
        tapGesture.numberOfTapsRequired = 1
        messageImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func openImage() {
        onImageClicked()
    }
}
