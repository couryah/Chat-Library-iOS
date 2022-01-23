//
//  ReceiverTextTableViewCell.swift
//  Chat Library
//
//  Created by Omar on 1/5/22.
//

import UIKit

class ReceiverTextTableViewCell: TextTableViewCell {

    @IBOutlet weak var polygonImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        polygonImage.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    static func getIdentifier() -> String {
        return "ReceiverTextTableViewCell"
    }
}
