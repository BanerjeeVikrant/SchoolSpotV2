//
//  PostDataArray.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 12/30/18.
//  Copyright © 2018 Vikrant Banerjee. All rights reserved.
//

import Foundation

class PostDataArray {
    var postDataArray:[PostData] = [PostData]()
    let maxSize:Int = 16
    var currSize:Int = 0
    var minIdx:Int = 0
    var minLoc:Int = 0
    let sizeRequest = 5
    var type: Int = -1;

    func get(index:Int, tabType: Int) -> PostData {
        type = tabType
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
        return postDataArray[(index-minIdx+minLoc) % maxSize]
    }
    func pushBack(cell: PostData) {
        if (currSize < maxSize) {
            postDataArray.append(cell)
            currSize = currSize + 1
        } else {
            postDataArray[minLoc] = cell
            minLoc = (minLoc + 1) % maxSize
            minIdx = minIdx + 1
        }
    }
    func pushFront(cell: PostData) {
        if (minIdx > 0) {
            minLoc = (minLoc + maxSize - 1) % maxSize
            postDataArray[minLoc] = cell
            minIdx = minIdx-1
            if (currSize < maxSize) {
                currSize = currSize + 1
            }
        }
    }
    func loadNext() {
        let postArray: NSArray = loadPostFromUrl(offset: minIdx+currSize)
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
        let postArray: NSArray = loadPostFromUrl(offset: offset, cnt: cnt)
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
    
    func createPostData(postDict:NSDictionary) -> PostData {
        let id = postDict.value(forKey: "id")
        let name = postDict.value(forKey: "name") as! String
        let time = postDict.value(forKey: "time")
        var userPic = postDict.value(forKey: "userpic") as! String
        let caption = postDict.value(forKey: "body")
        var postPicture = postDict.value(forKey: "picture_added") as! String
        
        if(postPicture == "http://www.bruincave.com/m/"){
            postPicture = ""
        }
        
        if(userPic == "http://www.bruincave.com/m/"){
            userPic = "https://www.adorama.com/alc/wp-content/uploads/2017/07/10632388566_af8e22ea3a_o.jpg"
        }
        
        let likedByMe = postDict.value(forKey: "likedByMe") as! Int
        let likes = postDict.value(forKey: "likesCount") as! Int
        
        var postPic: UIImage? = nil
        if (postPicture != "") {
            let postimgURL = NSURL(string: postPicture)
            if postimgURL != nil {
                let data = NSData(contentsOf: (postimgURL as URL?)!)
                let postPicOrig = UIImage(data:  data! as Data)
                postPic = UIImage(data: data! as Data, scale: (postPicOrig!.size.width/UIScreen.main.bounds.width))
            }
        }
        
        let imgURL = NSURL(string: userPic)
        var userImage: UIImage? = nil
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            userImage = UIImage(data: data! as Data)
        }
        
        return PostData(id: id as! Int, userName: name, like: (likedByMe != 0), likeCount: likes, image: postPic, time: time as! String, userImage: userImage!, caption: caption as! String)
    }
    
    func loadPostFromUrl(offset:Int, cnt:Int = 5) -> NSArray {
        let defaults = UserDefaults.standard
        var usernameSet: String = ""
        if(defaults.string(forKey: "username") != nil){
            usernameSet = defaults.string(forKey: "username")!
        }
        
        let myUrl = URL(string: "http://www.bruincave.com/files/bringposts.php");
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = "type="+String(type)+"&o="+String(offset)+"&n="+String(cnt)+"&username="+usernameSet;
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
