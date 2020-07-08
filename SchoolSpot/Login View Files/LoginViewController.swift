//
//  LoginViewController.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 11/16/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    /*
     TextField: Username, Password
     Button: Login, Register
    */
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clear any inital input
        usernameTF.text = ""
        passwordTF.text = ""
        
        // See functionality in SignInHelper.swift
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginOnClickListener(_ sender: Any) {
        // get current Text from TF: username, password
        let username: String = usernameTF.text!
        let password: String = passwordTF.text!
        
        /*
         Connection with the PHP-server: To check user login details
         Request METHOD: POST
         Database: MySQL
         Conenection with files/login.php
         @param: username, password
         @return - Bool - true for success
         */
        
        //create postString for the POST Method
        let postStringFinal = "username="+username+"&password="+password
        let myUrl = URL(string: "http://www.bruincave.com/files/login.php");
        
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.httpBody = postStringFinal.data(using: String.Encoding.utf8);
        
        let jsonDict: NSDictionary = httpConnection(postString: postStringFinal, pageUrl: "http://www.bruincave.com/files/login.php")
        
        if let success: Bool = jsonDict.value(forKey: "success") as? Bool {
            print(jsonDict)
            
            // key success returns true
            if(success == true){
                resetDefaults()
                let defaults = UserDefaults.standard
                defaults.set(username, forKey: "verfiedUsername")
                defaults.set(password, forKey: "verifiedPassword")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                //Go to the homeView
                
                let homeViewController = storyBoard.instantiateViewController(withIdentifier: "homeView")
                DispatchQueue.main.async(execute: {
                    self.present(homeViewController, animated: true, completion: nil)
                })
            }
            else{
                let refreshAlert = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func registerOnClickListener(_ sender: Any) {
        
        // open the first registration view controller
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationFirstPageVC = storyboard.instantiateViewController(withIdentifier: "register1") as UIViewController
        DispatchQueue.main.async(execute: {
            self.present(registrationFirstPageVC, animated: true, completion: nil)
        })
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
