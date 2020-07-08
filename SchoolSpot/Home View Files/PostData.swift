//
//  PostData.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/30/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import Foundation
import UIKit

class PostData {
    var id: Int
    var userName: String
    var userImage: UIImage
    var time: String
    var like: Bool
    var likeCount: Int
    var image: UIImage?
    var caption: String
    
    init(id: Int, userName: String, like: Bool, likeCount: Int, image: UIImage?, time: String, userImage: UIImage, caption: String) {
        self.id = id
        self.userName = userName
        self.userImage = userImage
        self.like = like
        self.likeCount = likeCount
        self.image = image
        self.time = time
        self.caption = caption
    }
}
