//
//  EmployeeModel.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/12/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation

class EmployeeModel: NSObject {
    
    var id: String?
    var email: String?
    var first_name: String?
    var last_name: String?
    var phone: String?
    var active: String?
    
    override init()
    {
        
    }
    
    init(id: String, email: String, first_name: String, last_name: String, phone: String?, active: String?)
    {
        self.id = id
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.phone = phone
        self.active = active
    }
    
    override var description: String {
        return "ID: \(id) Email: \(email), First Name: \(first_name), Last Name: \(last_name) Phone Number: \(phone) Active: \(active)"
    }
    
}
