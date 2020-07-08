//
//  SignInDataBaseConnection.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/26/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import Foundation

func httpConnection(postString: String, pageUrl: String) -> NSDictionary {
    
    let urlRead = DispatchSemaphore(value: 0)
    
    let myUrl = URL(string: pageUrl);
    var request = URLRequest(url:myUrl!)
    var jsonDict: NSDictionary? = nil
    
    request.httpMethod = "POST"
    request.httpBody = postString.data(using: String.Encoding.utf8);
    
    URLSession.shared.dataTask(with: request) {
        (data: Data?, response: URLResponse?, error: Error?) in
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            if(json != nil) {
                if let jsonArray = json?["json"] as? NSArray{
                    for jsonElement in jsonArray {
                        jsonDict = (jsonElement as? NSDictionary)!
                        urlRead.signal()
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }.resume()
    urlRead.wait()
    
    return jsonDict!
}
