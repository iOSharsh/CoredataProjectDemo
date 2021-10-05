//
//  UserDataShowFileTableViewCell.swift
//  CoredataProjectDemo
//
//  Created by mac on 27/01/21.
//

import UIKit

class UserDataShowFileTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVieww: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileNoLabl: UILabel!
    @IBOutlet weak var blankView: UIView!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageVieww.layer.cornerRadius = imageVieww.frame.height/2
        self.imageVieww.clipsToBounds = true
        self.imageVieww.layer.borderWidth = 1
        self.imageVieww.layer.borderColor = UIColor.lightText.cgColor
        
        blankView.layer.cornerRadius = 20
        self.blankView.clipsToBounds = true
        self.blankView.layer.borderWidth = 1
        self.blankView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
