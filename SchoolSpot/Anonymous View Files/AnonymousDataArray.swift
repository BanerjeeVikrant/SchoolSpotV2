//
//  AnonymousDataArray.swift
//  SchoolSpot
//
//  Created by Vikrant Banerjee on 1/4/19.
//  Copyright © 2019 Vikrant Banerjee. All rights reserved.
//

import Foundation

class AnonymousDataArray {
    var anonymousDataArray:[AnonymousData] = [AnonymousData]()
    let maxSize:Int = 16
    var currSize:Int = 0
    var minIdx:Int = 0
    var minLoc:Int = 0
    let sizeRequest = 5
    
    func get(index:Int) -> AnonymousData {
        
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
        return anonymousDataArray[(index-minIdx+minLoc) % maxSize]
    }
    func pushBack(cell: AnonymousData) {
        if (currSize < maxSize) {
            anonymousDataArray.append(cell)
            currSize = currSize + 1
        } else {
            anonymousDataArray[minLoc] = cell
            minLoc = (minLoc + 1) % maxSize
            minIdx = minIdx + 1
        }
    }
    func pushFront(cell: AnonymousData) {
        if (minIdx > 0) {
            minLoc = (minLoc + maxSize - 1) % maxSize
            anonymousDataArray[minLoc] = cell
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
    
    func createPostData(postDict:NSDictionary) -> AnonymousData {
        let id = postDict.value(forKey: "id")
        let time = postDict.value(forKey: "time")
        let caption = postDict.value(forKey: "body")
        
        return AnonymousData(id: id as! Int, time: time as! String, caption: caption as! String)
    }
    
    func loadPostFromUrl(offset:Int, cnt:Int = 5) -> NSArray {
        
        let myUrl = URL(string: "http://www.bruincave.com/files/bringanonymous.php");
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
