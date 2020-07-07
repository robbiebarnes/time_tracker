//
//  DownloadEmployeesModel.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/12/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation

protocol DownloadEmployeesProtocol: class {
    func employeeItemsDownloaded(items: [EmployeeModel])
}

class DownloadEmployeesModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : DownloadEmployeesProtocol!
    
    let urlPath: String = "http://cgi.soic.indiana.edu/~rojbarne/findEmployees.php"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            let task = defaultSession.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("Failed to download data")
                }else {
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
            var employees: [EmployeeModel] = []
            
            for i in 0 ..< jsonResult.count {
                
                jsonElement = jsonResult[i] as! NSDictionary
                
                
                if let id = jsonElement["id"] as? String,
                    let email = jsonElement["email"] as? String,
                    let first_name = jsonElement["first_name"] as? String,
                    let last_name = jsonElement["last_name"] as? String,
                    let phone = jsonElement["phone"] as? String,
                    let active = jsonElement["active"] as? String {
                    
                    let employee = EmployeeModel(id: id, email: email, first_name: first_name, last_name: last_name, phone: phone, active: active)
                    employees.append(employee)
                }
                
                
            }
            print(jsonElement)
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.employeeItemsDownloaded(items: employees)
                
            })

        }
    
}
