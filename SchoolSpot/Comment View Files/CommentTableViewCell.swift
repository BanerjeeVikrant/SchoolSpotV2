//
//  CommentTableViewCell.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/15/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
