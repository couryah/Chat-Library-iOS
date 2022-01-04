//
//  SenderTextTableViewCell.swift
//  Chat Library
//
//  Created by Omar on 1/4/22.
//

import UIKit

class SenderTextTableViewCell: UITableViewCell {

    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tickImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
