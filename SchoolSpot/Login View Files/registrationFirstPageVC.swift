//
//  registrationFirstPageVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/26/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import UIKit

class registrationFirstPageVC: UIViewController {
    
    /*
     TextField: firstname, lastname
    */
    
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // See functionality in Helper.swift
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func backOnClickListener(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextOnClickListener(_ sender: Any) {
        // Get firstname and lastname
        let firstnameInput: String = firstnameTF.text!
        let lastnameInput: String = lastnameTF.text!
        
        
        
        
        if(firstnameInput != "" && lastnameInput != "" && verifyInputs(firstname: firstnameInput, lastname: lastnameInput, email: "", year: "", gender: "", username: "", password: "", repeatPassword: "")){
            
            // save firstname and last name in User defaults
            let defaults = UserDefaults.standard
            defaults.set(firstnameInput, forKey: "userFirstName")
            defaults.set(lastnameInput, forKey: "userLastName")
            
            // change storyBoard to registrationSecondPage View Controller
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let registrationSecondPageVC = storyBoard.instantiateViewController(withIdentifier: "register2")
            
            DispatchQueue.main.async(execute: {
                self.present(registrationSecondPageVC, animated: true, completion: nil)
            })
            
            
        }
        else {
            var messagePop: String = ""
            
            if(firstnameInput == "" || lastnameInput == "") {
                 messagePop = "Please complete all the questions"
            }
            else{
                messagePop = "Please remove all Invalid Characters and spaces"
            }
            
            let refreshAlert = UIAlertController(title: "Error", message: messagePop, preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
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
