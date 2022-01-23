//
//  SenderTextTableViewCell.swift
//  Chat Library
//
//  Created by Omar on 1/4/22.
//

import UIKit

class SenderTextTableViewCell: TextTableViewCell {

    @IBOutlet var tickImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getIdentifier() -> String {
        return "SenderTextTableViewCell"
    }
}
