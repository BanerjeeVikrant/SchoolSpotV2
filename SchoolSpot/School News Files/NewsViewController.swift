//
//  NewsViewController.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/9/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var newsDataArray: NewsDataArray = NewsDataArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            menu.target = revealViewController()
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func tableView(_ postTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCnt = 0;
        let urlRead = DispatchSemaphore(value: 0)
        let url = URL(string: "http://www.bruincave.com/files/newscount.php")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let rowCntStr:String = String(data: data, encoding: String.Encoding.utf8) ?? "0"
            rowCnt = Int(rowCntStr) ?? 0
            urlRead.signal()
            }.resume()
        urlRead.wait()
        return rowCnt
    }
    
    func tableView(_ postTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx:Int = indexPath.row
        let cell = postTableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsTableViewCell
        newsDataArray.cellWidth = cell.postImage.frame.width
        
        let newsData: NewsData = newsDataArray.get(index: idx)
        
        let event = newsData.eventType
        
        if(event == 1){
            cell.captionLabel.font = UIFont(name: "Verdana-Bold", size: 20.0)
        }
        
        cell.timeLabel.text = newsData.time
        cell.captionLabel.text = newsData.caption
        cell.postImage.image = newsData.image
        
        return cell
    }
    


}
