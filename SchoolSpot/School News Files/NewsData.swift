//
//  NewsData.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/9/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

class NewsData {
    var id: Int
    var time: String
    var image: UIImage?
    var caption: String
    var eventType: Int
    
    init(id: Int, image: UIImage?, time: String, caption: String, eventType: Int) {
        self.id = id
        self.image = image
        self.time = time
        self.caption = caption
        self.eventType = eventType
    }
}
