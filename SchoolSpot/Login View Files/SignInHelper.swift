//
//  SignInHelper.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/26/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import Foundation
import UIKit

/*
 Checks if the inputs {firstname, lastname, email, year, gender, username, password} are valid.
 
 @param firstname, lastname, email, year, gender, username, password, repeatPassword
 @return - Bool - true if all the input types are valid

*/

func verifyInputs(firstname: String, lastname: String, email: String, year: String, gender: String, username: String, password: String, repeatPassword: String) -> Bool {
    
    
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    /*
        Checks for valid Email
        @param email
        @return - Bool - Validity
     */
    func isValidEmail(testEmail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testEmail)
    }
    /*
        Checks for valid username
        @param username
        @return - Bool - Validity
     */
    func isValidUsername(Input:String) -> Bool {
        let RegEx = "\\w{7,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    /*
        Checks for valid password
        @param password
        @return - Bool - Validity
     */
    func isValidPassword(Input: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: Input)
    }
    
    // Check for validity ONLY IF STRING NOT EMPTY
    // EMPTY string are checked in touch files
    
    if(firstname != ""){
        if (firstname.rangeOfCharacter(from: characterset.inverted) != nil){
            return false
        }
    }
    if(lastname != ""){
        if(lastname.rangeOfCharacter(from: characterset.inverted) != nil){
            return false
        }
    }
    if(email != ""){
        if(isValidEmail(testEmail: email) != true){
            return false
        }
    }
    if(year != ""){
        if(year != "Freshman" && year != "Sophomore" && year != "Junior" && year != "Senior"){
            return false
        }
    }
    if(gender != ""){
        if(gender != "Male" && gender != "Female"){
            return false
        }
    }
    if(username != ""){
        if(isValidUsername(Input: username) != true){
            return false
        }
    }
    if(password != ""){
        //isValidPassword(Input: password) != true ||
        if(password != repeatPassword){
            return false
        }
    }
        
    // if nothing else returns - everything valid
    return true
}


