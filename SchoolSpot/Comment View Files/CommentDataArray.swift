//
//  CommentDataArray.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/15/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

class CommentDataArray {
    var commentDataArray:[CommentData] = [CommentData]()
    let maxSize:Int = 8
    var currSize:Int = 0
    var minIdx:Int = 0
    var minLoc:Int = 0
    let sizeRequest = 5
    
    func get(index:Int) -> CommentData {
        
        if (index >= (minIdx+currSize) && index < (minIdx+currSize+sizeRequest)) {
            loadNext()
        } else if (index < minIdx && (index + sizeRequest) > minIdx) {
            loadPrev()
        } else if (index < minIdx || index >= minIdx+currSize){
            var loadIdx = index-sizeRequest/2
            if (loadIdx < 0) {
                loadIdx = 0
            }
            loadAt(index:loadIdx)
        }
        return commentDataArray[(index-minIdx+minLoc) % maxSize]

    }
    func pushBack(cell: CommentData) {
        if (currSize < maxSize) {
            commentDataArray.append(cell)
            currSize = currSize + 1
        } else {
            commentDataArray[minLoc] = cell
            minLoc = (minLoc + 1) % maxSize
            minIdx = minIdx + 1
        }
    }
    func pushFront(cell: CommentData) {
        if (minIdx > 0) {
            minLoc = (minLoc + maxSize - 1) % maxSize
            commentDataArray[minLoc] = cell
            minIdx = minIdx-1
            if (currSize < maxSize) {
                currSize = currSize + 1
            }
        }
    }
    func loadNext() {
        let postArray: NSArray = loadPostFromUrl(postid: 187)
        for post in postArray{
            if let postDict = post as? NSDictionary {
                let postData = createPostData(postDict: postDict)
                self.pushBack(cell: postData)
            }
        }
    }
    
    func loadPrev() {
        var offset = minIdx-sizeRequest
        var cnt = sizeRequest
        if (offset<0) {
            cnt = sizeRequest + offset
            offset = 0
        }
        let postArray: NSArray = loadPostFromUrl(postid: 187)
        for post in postArray.reversed() {
            if let postDict = post as? NSDictionary {
                let postData = createPostData(postDict: postDict)
                self.pushFront(cell: postData)
            }
        }
    }
    
    func loadAt(index:Int) {
        minLoc = 0
        minIdx = index
        currSize = 0
        loadNext()
    }
    var cellWidth:CGFloat = 155.0;
    
    func createPostData(postDict:NSDictionary) -> CommentData {
        let id = postDict.value(forKey: "id")
        let userName = postDict.value(forKey: "name")
        let caption = postDict.value(forKey: "comment")
        var userPic = postDict.value(forKey: "image") as! String
        
        if(userPic == "http://www.bruincave.com/m/"){
            userPic = "https://www.adorama.com/alc/wp-content/uploads/2017/07/10632388566_af8e22ea3a_o.jpg"
        }
        
        let imgURL = NSURL(string: userPic)
        var userImage: UIImage? = nil
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            userImage = UIImage(data: data! as Data)
        }
        
        return CommentData(id: id as! Int, userName: userName as! String, caption: caption as! String, userImage: userImage!)
    }
    
    func loadPostFromUrl(postid: Int) -> NSArray {
        
        let myUrl = URL(string: "http://www.bruincave.com/files/bringcomments.php");
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = "type="+String(1)+"&postid="+String(postid);
        request.httpBody = postString.data(using: String.Encoding.utf8);
        var postArray:NSArray?
        let urlRead = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Convert response sent from a server side script toa NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if json != nil {
                    postArray = json?["json"] as? NSArray
                }
                urlRead.signal()
            } catch {
                print(error)
            }
        }
        task.resume()
        urlRead.wait()
        return postArray!
    }
}
