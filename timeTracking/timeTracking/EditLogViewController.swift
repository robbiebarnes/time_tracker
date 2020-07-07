//
//  EditLogViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

class EditLogViewContoller: UIViewController {
    
    @IBOutlet weak var employeeFirstName: UITextField!
    @IBOutlet weak var employeeLastName: UITextField!
    @IBOutlet weak var employeeEmail: UITextField!
    @IBOutlet weak var startDatetime: UIDatePicker!
    @IBOutlet weak var endDatetime: UIDatePicker!
    
    func setDate(timeDate: String) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: timeDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeFirstName.isUserInteractionEnabled = false
        employeeLastName.isUserInteractionEnabled = false
        employeeEmail.isUserInteractionEnabled = false
    }
    var selectedLog = LogModel()
    
    override func viewDidAppear(_ animated: Bool) {
        employeeFirstName.text = selectedLog.first_name
        employeeLastName.text = selectedLog.last_name
        employeeEmail.text = selectedLog.email
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let start = dateFormatter.date(from: selectedLog.start_datetime!)
        startDatetime.setDate(start!, animated: false)
        let end = dateFormatter.date(from: selectedLog.end_datetime!)
        if end != nil {
            endDatetime.setDate(end!, animated: false)
        }
        
    }
    
    @IBAction func updateLogButton(_ sender: UIButton) {
        updateLog()
    }
    
    
    func updateLog() {
        startDatetime.datePickerMode = UIDatePicker.Mode.dateAndTime
        endDatetime.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDate = dateFormatter.string(from: startDatetime.date)
        let endDate = dateFormatter.string(from: endDatetime.date)
        
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/updateLog.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(selectedLog.id!)"
        dataString = dataString + "&start_datetime=\(startDate)"
        dataString = dataString + "&end_datetime=\(endDate)"

        let dataD = dataString.data(using: .utf8)

        do {
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD) {
                data, response, error in
                if error != nil {
                        print("It didn't work!")
                }
                else {
                    if let unwrappedData = data {
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        print(returnedData)
                        if returnedData == "1" {
                            print("Log Updated")
                        }
                        else {
                            print("It didn't work")
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
}
