//
//  Helper.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/4/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation
import UIKit

/*
 To get rid of keyBoard from all UIViewController
 Creates an extention of UIViewController and defines the function.
 */
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


