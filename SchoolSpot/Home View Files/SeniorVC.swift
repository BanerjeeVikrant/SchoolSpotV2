//
//  SeniorVC.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/7/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class SeniorVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postDataArray: PostDataArray = PostDataArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func tableView(_ postTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCnt = 0;
        let urlRead = DispatchSemaphore(value: 0)
        let url = URL(string: "http://www.bruincave.com/files/postcount.php?type=4")!
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
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCellSenior") as! PostTableViewCell
        postDataArray.cellWidth = cell.postImage.frame.width
        let postData: PostData = postDataArray.get(index: idx, tabType: 4)
        
        cell.nameLabel.text = postData.userName
        cell.timeLabel.text = postData.time
        cell.captionLabel.text = postData.caption
        cell.profilePicImage.image = postData.userImage
        cell.profilePicImage.setRounded()
        cell.likeCount.setTitle(String(postData.likeCount), for: [])
        if(postData.like == false){
            cell.likeButton.setImage(UIImage(named: "bearicon"), for: .normal)
        }else{
            cell.likeButton.setImage(UIImage(named: "bearicongrey"), for: .normal)
        }
        /*
         print("ImageView:" + String(describing: cell.postImage.frame.width) + " x " + String(describing: cell.postImage.frame.height))
         print("  Image:" + String(describing: postData.image.size.width) + " x " + String(describing: postData.image.size.height))
         */
        
        cell.postImage.image = postData.image
        
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
