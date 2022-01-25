//
//  SenderImageTableViewCell.swift
//  Chat Library
//
//  Created by Omar on 24/01/2022.
//

import UIKit

class SenderImageTableViewCell: ImageTableViewCell {

    @IBOutlet weak var tickImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func getIdentifier() -> String {
        return "SenderImageTableViewCell"
    }
}
