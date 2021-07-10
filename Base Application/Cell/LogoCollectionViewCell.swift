//
//  LogoCollectionViewCell.swift
//  Base Application
//
//  Created by Ahsanul Kabir on 10/7/21.
//  Copyright © 2021 sakibwrold. All rights reserved.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(_ image: UIImage){
        logoImageView.image = image
    }

}
