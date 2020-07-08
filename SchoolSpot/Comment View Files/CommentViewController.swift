//
//  CommentViewController.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/15/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource {

    var commentDataArray: CommentDataArray = CommentDataArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func tableView(_ commentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return 20
    }
    
    func tableView(_ commentTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx:Int = indexPath.row
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentTableViewCell
        
        let commentData: CommentData = commentDataArray.get(index: idx)
        
        cell.userName.text = commentData.userName
        cell.comment.text = commentData.caption
        cell.userPic.image = commentData.userImage
        
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
