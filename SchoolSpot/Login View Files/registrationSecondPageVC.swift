//
//  registrationSecondPageVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/26/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import UIKit

class registrationSecondPageVC: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See functionality in Helper.swift
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func backOnClickListener(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yearOnClickListener(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Year", message: "Choose your year", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Freshman", style: .default, handler: { (action: UIAlertAction!) in
            self.yearButton.setTitle("Freshman", for: .normal)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Sophomore", style: .default, handler: { (action: UIAlertAction!) in
            self.yearButton.setTitle("Sophomore", for: .normal)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Junior", style: .default, handler: { (action: UIAlertAction!) in
            self.yearButton.setTitle("Junior", for: .normal)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Senior", style: .default, handler: { (action: UIAlertAction!) in
            self.yearButton.setTitle("Senior", for: .normal)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func genderOnClickListener(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Gender", message: "Choose what suits best", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (action: UIAlertAction!) in
            self.genderButton.setTitle("Male", for: .normal)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (action: UIAlertAction!) in
            self.genderButton.setTitle("Female", for: .normal)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let current_year: String = yearButton.currentTitle!
        let current_gender: String = genderButton.currentTitle!
        let current_email: String = emailTF.text!
        
        if(current_email != "" && current_year != "Select Graduation Year" && current_gender != "Select Gender" && verifyInputs(firstname: "", lastname: "", email: current_email, year: current_year, gender: current_gender, username: "", password: "", repeatPassword: "")){
            
            let defaults = UserDefaults.standard
            defaults.set(current_email, forKey: "userEmail")
            defaults.set(current_year, forKey: "userYear")
            defaults.set(current_gender, forKey: "userGender")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "register3")
            
            DispatchQueue.main.async(execute: {
                self.present(newViewController, animated: true, completion: nil)
            })
        } else {
            
            let refreshAlert = UIAlertController(title: "Error", message: "Please complete all questions in correct format and remove spaces", preferredStyle: UIAlertController.Style.alert)
            
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
