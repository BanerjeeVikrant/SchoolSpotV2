//
//  HomeHelper.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/6/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}


