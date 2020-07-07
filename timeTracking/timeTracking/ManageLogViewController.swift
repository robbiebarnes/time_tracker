//
//  ManageLogViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

var startOrEnd = ""

class ManageLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DownloadEmployeesProtocol {
    
    var feedItems: [EmployeeModel] = []
    var selectedEmployee = EmployeeModel()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var employeeDropDown: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDropDown.delegate = self
        employeeDropDown.dataSource = self
        
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
        
        self.employeeDropDown.isHidden = true
        clock.isHidden = true
        submitButton.isHidden = true
        
    
    }
    
    func employeeItemsDownloaded(items: [EmployeeModel]) {
        feedItems = items
        self.employeeDropDown.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId: String = "employeeCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let item: EmployeeModel = feedItems[indexPath.row]
        myCell.textLabel!.text = "\(item.active!)  -  \(item.first_name!) \(item.last_name!)"
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UIView.animate(withDuration: 0.5) {
            self.employeeDropDown.isHidden = true
        }
        
        selectedEmployee = feedItems[indexPath.row]
        
        button.setTitle("\(selectedEmployee.first_name!) \(selectedEmployee.last_name!)", for: .normal)
        if (selectedEmployee.active == "Y") {
            clock.isHidden = false
            submitButton.isHidden = false
            checkIfClockedOut()
            
        }
        else {
            clock.isHidden = true
            submitButton.isHidden = true
        }
    }
    
    @IBAction func selectEmployeeButton(_ sender: Any) {
        if (self.employeeDropDown.isHidden) {
            UIView.animate(withDuration: 0.5) {
                self.employeeDropDown.isHidden = false
                self.employeeDropDown.layer.borderColor = UIColor.black.cgColor
                self.employeeDropDown.layer.borderWidth = 2.0
                self.employeeDropDown.layer.zPosition = 100
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.employeeDropDown.isHidden = true
            }
        }
        let downloadEmployeesModel = DownloadEmployeesModel()
        downloadEmployeesModel.delegate = self
        downloadEmployeesModel.downloadItems()
    }
    
    
    
    @IBOutlet weak var clock: UIDatePicker!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBAction func submitEmpolyeeHours(_ sender: UIButton) {
        printEmployeeHours()
        if startOrEnd == "Clock In" {
            addClockInHours()
        }
        else {
            addClockOutHours()
        }
        
    }
    
    func printEmployeeHours() {
        clock.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let selectedDate = dateFormatter.string(from: clock.date)
        print("Name: \(selectedEmployee.first_name!) \(selectedEmployee.last_name!) \n\(selectedDate)")
    }
    
    func printInfo(_ value: Any) {
        let t = type(of: value)
        print("'\(value)' of type '\(t)'")
    }
    
    func checkIfClockedOut() {
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/checkIfClockedOut.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(selectedEmployee.id!)"

        let dataD = dataString.data(using: .utf8)

        do {
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD) {
                data, response, error in
                if error != nil {
                        print("It didn't work!")
                }
                else {
                    if let unwrappedData = data {
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) as! String
                        self.printInfo(returnedData)
                        if String(returnedData) == "\n" {
                            print("Need to Clock out")
                            startOrEnd = "Clock Out"
                        }
                        else {
                            print("Need to Clock in")
                            startOrEnd = "Clock In"
                            
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
    
    func addClockInHours() {
        clock.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var selectedDate = dateFormatter.string(from: clock.date)
        
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/addClockInHours.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(selectedEmployee.id!)"
        dataString = dataString + "&start_datetime=\(selectedDate)"

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
                        if returnedData == "1" {
                            print("Hours Add to Clock In")
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
    
    func addClockOutHours() {
        clock.datePickerMode = UIDatePicker.Mode.dateAndTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var selectedDate = dateFormatter.string(from: clock.date)
        
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/addClockOutHours.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(selectedEmployee.id!)"
        dataString = dataString + "&end_datetime=\(selectedDate)"

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
                        if returnedData == "1" {
                            print("Hours Add To Clock out")
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
