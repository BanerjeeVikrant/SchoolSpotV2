//
//  NavigationVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/4/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class NavigationVC: UIViewController {
    
    @IBOutlet weak var homeNavView: UIView!
    @IBOutlet weak var anonymousNavView: UIView!
    @IBOutlet weak var schoolNavView: UIView!
    @IBOutlet weak var messageNavView: UIView!
    @IBOutlet weak var settingsNavView: UIView!
    @IBOutlet weak var feedbackNavView: UIView!
    @IBOutlet weak var logoutNavView: UIView!
    
    
    var homeTapGesture = UITapGestureRecognizer()
    var anonymousTapGesture = UITapGestureRecognizer()
    var notificationsTapGesture = UITapGestureRecognizer()
    var messagesTapGesture = UITapGestureRecognizer()
    var settingsTapGesture = UITapGestureRecognizer()
    var feedbackTapGesture = UITapGestureRecognizer()
    var logoutTapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // On HomeView Tapped
        homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(NavigationVC.homeViewTapped(_:)))
        homeTapGesture.numberOfTapsRequired = 1
        homeTapGesture.numberOfTouchesRequired = 1
        homeNavView.addGestureRecognizer(homeTapGesture)
        homeNavView.isUserInteractionEnabled = true
        
        // On AnonymousView Tapped
        anonymousTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.anonymousViewTapped(_:)))
        anonymousTapGesture.numberOfTapsRequired = 1
        anonymousTapGesture.numberOfTouchesRequired = 1
        anonymousNavView.addGestureRecognizer(anonymousTapGesture)
        anonymousNavView.isUserInteractionEnabled = true
        
        // On SchoolView Tapped
        notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.notificationsViewTapped(_:)))
        notificationsTapGesture.numberOfTapsRequired = 1
        notificationsTapGesture.numberOfTouchesRequired = 1
        schoolNavView.addGestureRecognizer(notificationsTapGesture)
        schoolNavView.isUserInteractionEnabled = true
        
        // On MessagesView Tapped
        messagesTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.messagesViewTapped(_:)))
        messagesTapGesture.numberOfTapsRequired = 1
        messagesTapGesture.numberOfTouchesRequired = 1
        messageNavView.addGestureRecognizer(messagesTapGesture)
        messageNavView.isUserInteractionEnabled = true
        
        // On SettingsView Tapped
        settingsTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.settingsViewTapped(_:)))
        settingsTapGesture.numberOfTapsRequired = 1
        settingsTapGesture.numberOfTouchesRequired = 1
        settingsNavView.addGestureRecognizer(settingsTapGesture)
        settingsNavView.isUserInteractionEnabled = true
        
        // On FeedbackView Tapped
        feedbackTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.feedbackViewTapped(_:)))
        feedbackTapGesture.numberOfTapsRequired = 1
        feedbackTapGesture.numberOfTouchesRequired = 1
        feedbackNavView.addGestureRecognizer(feedbackTapGesture)
        feedbackNavView.isUserInteractionEnabled = true
        
        // On LogoutView Tapped
        logoutTapGesture = UITapGestureRecognizer(target: self, action: #selector (NavigationVC.logoutViewTapped(_:)))
        logoutTapGesture.numberOfTapsRequired = 1
        logoutTapGesture.numberOfTouchesRequired = 1
        logoutNavView.addGestureRecognizer(logoutTapGesture)
        logoutNavView.isUserInteractionEnabled = true
    }
    
@objc func homeViewTapped(_ sender: UITapGestureRecognizer) {
    
    let progressIndicator = LoadingActivityIndicator(text: "Loading Home..")
    self.view.addSubview(progressIndicator)
    
    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! SWRevealViewController
    self.present(homeVC, animated: true, completion: nil)
}
@objc func anonymousViewTapped(_ sender: UITapGestureRecognizer) {
    
    let progressIndicator = LoadingActivityIndicator(text: "Loading Anonymous..")
    self.view.addSubview(progressIndicator)
    
    let trackingVC = self.storyboard?.instantiateViewController(withIdentifier: "anonymousView") as! SWRevealViewController
    self.present(trackingVC, animated: true, completion: nil)
}
@objc func notificationsViewTapped(_ sender: UITapGestureRecognizer) {
    
    let progressIndicator = LoadingActivityIndicator(text: "Loading Events..")
    self.view.addSubview(progressIndicator)
    
    let trackingVC = self.storyboard?.instantiateViewController(withIdentifier: "newsView") as! SWRevealViewController
    self.present(trackingVC, animated: true, completion: nil)
}
@objc func messagesViewTapped(_ sender: UITapGestureRecognizer) {
    
}
@objc func settingsViewTapped(_ sender: UITapGestureRecognizer) {
    
}
@objc func feedbackViewTapped(_ sender: UITapGestureRecognizer) {
    
}
@objc func logoutViewTapped(_ sender: UITapGestureRecognizer) {
    resetDefaults()
    
    let progressIndicator = LoadingActivityIndicator(text: "Logging out..")
    self.view.addSubview(progressIndicator)
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginView")
    self.present(newViewController, animated: true, completion: nil)
    
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
