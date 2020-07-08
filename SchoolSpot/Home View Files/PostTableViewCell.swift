//
//  PostTableViewCell.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/30/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeCount: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBAction func likeOnClickListener(_ sender: Any) {
    }
    @IBAction func commentOnClickListener(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
