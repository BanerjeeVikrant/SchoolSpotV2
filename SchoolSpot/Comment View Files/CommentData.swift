//
//  CommentData.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/15/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

class CommentData {
    var id: Int
    var caption: String
    var userName: String
    var userImage: UIImage
    
    init(id: Int, userName: String, caption: String, userImage: UIImage) {
        self.id = id
        self.caption = caption
        self.userName = userName
        self.userImage = userImage
    }
}
