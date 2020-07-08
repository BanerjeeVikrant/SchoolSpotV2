//
//  AnonymousPostVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/4/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class AnonymousPostVC: UIViewController {

    @IBOutlet weak var confessionTV: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func postButtonOnClickListener(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // See functionality in Helper.swift
        self.hideKeyboardWhenTappedAround()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
