//
//  DownloadLogsModel.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation

protocol DownloadLogsProtocol: class {
    func logItemsDownloaded(items: [LogModel])
}

class DownloadLogsModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : DownloadLogsProtocol!
    
    let urlPath: String = "http://cgi.soic.indiana.edu/~rojbarne/findLogs.php"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        var dataString = "&id=\(userID)"
        
        let dataD = dataString.data(using: .utf8)
        
        let task = URLSession.shared.uploadTask(with: request, from: dataD) {
        data, response, error in

            if error != nil {
                print("Failed to download data")
            }
            else {
                print("Data downloaded")
                self.parseJSON(data!)
            }

        }

        task.resume()
        }
        
        func parseJSON(_ data:Data) {
            
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                       
            }
            catch let error as NSError {
                print(error)
                       
            }
            
            var jsonElement = NSDictionary()
            var logs: [LogModel] = []
            
            for i in 0 ..< jsonResult.count {
                
                jsonElement = jsonResult[i] as! NSDictionary
                
                
                if let id = jsonElement["id"] as? String,
                    let email = jsonElement["email"] as? String,
                    let first_name = jsonElement["first_name"] as? String,
                    let last_name = jsonElement["last_name"] as? String,
                    let start_datetime = jsonElement["start_datetime"] as? String,
                    let end_datetime = jsonElement["end_datetime"] as? String {
                    
                    let log = LogModel(id: id, email: email, first_name: first_name, last_name: last_name, start_datetime: start_datetime, end_datetime: end_datetime)
                    logs.append(log)
                }
                
                
            }
            print(jsonElement)
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.logItemsDownloaded(items: logs)
                
            })

        }
    
}
