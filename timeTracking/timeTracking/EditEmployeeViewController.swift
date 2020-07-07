//
//  EditEmployeeViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/13/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

class EditEmployeeViewController : UIViewController {
    
    @IBOutlet weak var updateEmail: UITextField!
    @IBOutlet weak var updateFirstName: UITextField!
    @IBOutlet weak var updateLastName: UITextField!
    @IBOutlet weak var updatePhoneNumber: UITextField!
    @IBOutlet weak var updateActiveSwitch: UISwitch!
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var validation = ValidationModel()
    let error = UIColor.red
    
    @IBAction func emailValidator(_ sender: Any) {
        let email = validation.validateEmail(email: updateEmail.text!)
        if (email == false){
            updateEmail.layer.borderColor = error.cgColor
            updateEmail.layer.borderWidth = 1.0
            updateEmail.layer.cornerRadius = 4
            updateButton.isEnabled = false
        }
        else {
            updateEmail.layer.borderWidth = 0
            updateButton.isEnabled = true
        }
    }
    
    @IBAction func firstNameValidator(_ sender: Any) {
        let firstName = validation.valudateFirstName(firstName: updateFirstName.text!)
        if (firstName == false) {
            updateFirstName.layer.borderColor = error.cgColor
            updateFirstName.layer.borderWidth = 1.0
            updateFirstName.layer.cornerRadius = 4
            updateButton.isEnabled = false
        }
        else {
            updateFirstName.layer.borderWidth = 0
            updateButton.isEnabled = true
        }
    }
    
    @IBAction func lastNameValidator(_ sender: Any) {
        let lastName = validation.valudateLastName(lastName: updateLastName.text!)
        if (lastName == false) {
            updateLastName.layer.borderColor = error.cgColor
            updateLastName.layer.borderWidth = 1.0
            updateLastName.layer.cornerRadius = 4
            updateButton.isEnabled = false
        }
        else {
            updateLastName.layer.borderWidth = 0
            updateButton.isEnabled = true
        }
    }
    
    @IBAction func phoneNumberValidator(_ sender: Any) {
        let phoneNumber = validation.valudatePhoneNumber(phoneNumber: updatePhoneNumber.text!)
        if (phoneNumber == false) {
            updatePhoneNumber.layer.borderColor = error.cgColor
            updatePhoneNumber.layer.borderWidth = 1.0
            updatePhoneNumber.layer.cornerRadius = 4
            updateButton.isEnabled = false
        }
        else {
            updatePhoneNumber.layer.borderWidth = 0
            updateButton.isEnabled = true
        }
    }
    
    
    @IBAction func updateEmployeeButton(_ sender: UIButton) {
        printEmployee()
        updateEmployee()
    }
    
    func printEmployee() {
        var active = ""
        if updateActiveSwitch.isOn {
            active = "Y"
        }
        else {
            active = "N"
        }
        print("Email: \(updateEmail.text!) \nFirst Name: \(updateFirstName.text!) \nLast Name: \(updateLastName.text!) \nPhone Number: \(updatePhoneNumber.text!) \nActive: " + active)
    }

    var selectedEmployee = EmployeeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.selectedEmployee.active! == "Y" {
            deleteButton.isEnabled = false
        }
        else {
            deleteButton.isEnabled = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        updateEmail.text = self.selectedEmployee.email
        updateFirstName.text = self.selectedEmployee.first_name
        updateLastName.text = self.selectedEmployee.last_name
        updatePhoneNumber.text = self.selectedEmployee.phone
        if (self.selectedEmployee.active == "Y") {
            updateActiveSwitch.setOn(true, animated: false)
        }
        else {
            updateActiveSwitch.setOn(false, animated: false)
        }
    }
    
    @IBAction func activeSwitch(_ sender: UISwitch) {
        if  updateActiveSwitch.isOn == true {
            deleteButton.isEnabled = false
        }
        else {
            deleteButton.isEnabled = true
        }
    }
    
    
    func updateEmployee() {
        var active = ""
        if updateActiveSwitch.isOn {
            active = "Y"
        }
        else {
            active = "N"
        }
        
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/updateEmployee.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(self.selectedEmployee.id!)"
        dataString = dataString + "&email=\(updateEmail.text!)"
        dataString = dataString + "&first_name=\(updateFirstName.text!)"
        dataString = dataString + "&last_name=\(updateLastName.text!)"
        dataString = dataString + "&phone=\(updatePhoneNumber.text!)"
        dataString = dataString + "&active=\(active)"

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
                            print("Employee Updated")
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
    
    
    @IBAction func deleteEmployeeButton(_ sender: UIButton) {
        deleteEmployee()
    }
    
    func deleteEmployee() {
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/deleteEmployee.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&id=\(self.selectedEmployee.id!)"

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
                            print("Record Deleted Successfully")
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
