//
//  NewsDataArray.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/9/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

class NewsDataArray {
    var newsDataArray:[NewsData] = [NewsData]()
    let maxSize:Int = 16
    var currSize:Int = 0
    var minIdx:Int = 0
    var minLoc:Int = 0
    let sizeRequest = 5
    
    func get(index:Int) -> NewsData {
        
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
        return newsDataArray[(index-minIdx+minLoc) % maxSize]
    }
    func pushBack(cell: NewsData) {
        if (currSize < maxSize) {
            newsDataArray.append(cell)
            currSize = currSize + 1
        } else {
            newsDataArray[minLoc] = cell
            minLoc = (minLoc + 1) % maxSize
            minIdx = minIdx + 1
        }
    }
    func pushFront(cell: NewsData) {
        if (minIdx > 0) {
            minLoc = (minLoc + maxSize - 1) % maxSize
            newsDataArray[minLoc] = cell
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
    
    func createPostData(postDict:NSDictionary) -> NewsData {
        let id = postDict.value(forKey: "id")
        let time = postDict.value(forKey: "time")
        let caption = postDict.value(forKey: "body")
        let event = postDict.value(forKey: "event")
        var postPicture = postDict.value(forKey: "picture_added") as! String
        
        if(postPicture == "http://www.bruincave.com/m/"){
            postPicture = ""
        }
        
        
        
        var postPic: UIImage? = nil
        if (postPicture != "") {
            let postimgURL = NSURL(string: postPicture)
            if postimgURL != nil {
                let data = NSData(contentsOf: (postimgURL as URL?)!)
                let postPicOrig = UIImage(data:  data! as Data)
                postPic = UIImage(data: data! as Data, scale: (postPicOrig!.size.width/UIScreen.main.bounds.width))
            }
        }
        
        return NewsData(id: id as! Int, image: postPic, time: time as! String, caption: caption as! String, eventType: event as! Int)
    }
    
    func loadPostFromUrl(offset:Int, cnt:Int = 5) -> NSArray {
        
        let myUrl = URL(string: "http://www.bruincave.com/files/bringnews.php");
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = "o="+String(offset)+"&n="+String(cnt);
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
