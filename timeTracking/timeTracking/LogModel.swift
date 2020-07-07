//
//  LogModel.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation

class LogModel: NSObject {

    var id: String?
    var email: String?
    var first_name: String?
    var last_name: String?
    var start_datetime: String?
    var end_datetime: String?

    override init()
    {
        
    }

    init(id: String, email: String, first_name: String, last_name: String, start_datetime: String?, end_datetime: String?)
    {
        self.id = id
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.start_datetime = start_datetime
        self.end_datetime = end_datetime
    }

    override var description: String {
        return "ID: \(id) Email: \(email), First Name: \(first_name), Last Name: \(last_name) Start Datetime: \(start_datetime) End Datetime: \(end_datetime)"
    }
}
