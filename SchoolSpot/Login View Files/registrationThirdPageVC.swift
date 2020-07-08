//
//  registrationThirdPageVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/26/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import UIKit

class registrationThirdPageVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordAgainTF: UITextField!
    
    var loginError: Bool = false
    
    @IBAction func backOnClickListener(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // See functionality in Helper.swift
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        let current_username: String = usernameTF.text!
        let current_password: String = passwordTF.text!
        let current_passwordAgain: String = passwordAgainTF.text!
        
        let defaults = UserDefaults.standard
        let firstname = defaults.string(forKey: "userFirstName")
        let lastname = defaults.string(forKey: "userLastName")
        let year = defaults.string(forKey: "userYear")
        let email = defaults.string(forKey: "userEmail")
        let gender = defaults.string(forKey: "userGender")
        
        if(current_username != "" && current_password != "" && verifyInputs(firstname: "", lastname: "", email: "", year: "", gender: "", username: current_username, password: current_password, repeatPassword: current_passwordAgain)){
            
            /*
                Connection with the PHP-server
                Request METHOD: POST
                Database: MySQL
                Conenection with files/register.php
                @param: firstname, lastname, username, password, grade, gender, email
                @return - Bool - true for success
            */
            
            //create postString for the POST Method
            let postString3 = "&gender="+gender!+"&email="+email!
            let postString2 = "&password="+current_password+"&grade="+year!+postString3
            let postStringFinal = "firstname="+firstname!+"&lastname="+lastname!+"&username="+current_username+postString2
            
            let jsonDict: NSDictionary = httpConnection(postString: postStringFinal, pageUrl: "http://www.bruincave.com/files/register.php")
            
            if let success: Bool = jsonDict.value(forKey: "success") as? Bool {
                print(jsonDict)
                
                // key success returns true
                if(success == true){
                    resetDefaults()
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    //Go to the loginView
                    
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginView")
                    DispatchQueue.main.async(execute: {
                        self.present(loginViewController, animated: true, completion: nil)
                    })
                }
            }

        }
        else {
            let refreshAlert = UIAlertController(title: "Error", message: "Passwords do not match or invalid format", preferredStyle: UIAlertController.Style.alert)
            
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
