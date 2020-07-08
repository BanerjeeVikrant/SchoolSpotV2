//
//  AnonymousData.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/3/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation
import UIKit

class AnonymousData {
    var id: Int
    var time: String
    var caption: String
    
    init(id: Int, time: String, caption: String) {
        self.id = id
        self.time = time
        self.caption = caption
    }
}
