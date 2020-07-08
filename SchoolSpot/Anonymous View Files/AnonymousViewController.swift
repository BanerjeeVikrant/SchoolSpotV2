//
//  AnonymousViewController.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/4/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class AnonymousViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!

    var anonymousDataArray: AnonymousDataArray = AnonymousDataArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenus()
        sidePost()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    func sidePost(){
        if self.revealViewController() != nil {
            postButton.target = self.revealViewController()
            postButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().rightViewRevealWidth = self.view.frame.width * 0.9
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func tableView(_ postTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCnt = 0;
        let urlRead = DispatchSemaphore(value: 0)
        let url = URL(string: "http://www.bruincave.com/files/anonymouscount.php")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let rowCntStr:String = String(data: data, encoding: String.Encoding.utf8) ?? "0"
            rowCnt = Int(rowCntStr) ?? 0
            urlRead.signal()
            }.resume()
        urlRead.wait()
        return rowCnt
    }
    
    func tableView(_ anonymousTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx:Int = indexPath.row
        
        let cell = anonymousTableView.dequeueReusableCell(withIdentifier: "AnonymousCell") as! AnonymousTableViewCell
        
        let anonymousData: AnonymousData = anonymousDataArray.get(index: idx)
        
        cell.timeLabel.text = anonymousData.time
        cell.captionLabel.text = anonymousData.caption
        
        return cell
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
