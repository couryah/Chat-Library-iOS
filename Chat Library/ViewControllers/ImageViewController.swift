//
//  ImageViewController.swift
//  Chat Library
//
//  Created by Omar on 26/01/2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

}
