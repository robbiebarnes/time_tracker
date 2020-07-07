//
//  CreateEmployeeViewController.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/12/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation
import UIKit

class CreateEmployeeViewController: ViewController {
    
    @IBOutlet weak var employeeEmail: UITextField!
    @IBOutlet weak var employeeFirstName: UITextField!
    @IBOutlet weak var employeeLastName: UITextField!
    @IBOutlet weak var employeePhoneNumber: UITextField!
    @IBOutlet weak var employeeActiveSwitch: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    
    var validation = ValidationModel()
    let error = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailValidator(_ sender: Any) {
        let email = validation.validateEmail(email: employeeEmail.text!)
        if (email == false){
            employeeEmail.layer.borderColor = error.cgColor
            employeeEmail.layer.borderWidth = 1.0
            employeeEmail.layer.cornerRadius = 4
            button.isEnabled = false
        }
        else {
            employeeEmail.layer.borderWidth = 0
            button.isEnabled = true
        }
    }
    @IBAction func firstNameValidator(_ sender: UITextField) {
        let firstName = validation.valudateFirstName(firstName: employeeFirstName.text!)
        if (firstName == false) {
            employeeFirstName.layer.borderColor = error.cgColor
            employeeFirstName.layer.borderWidth = 1.0
            employeeFirstName.layer.cornerRadius = 4
            button.isEnabled = false
        }
        else {
            employeeFirstName.layer.borderWidth = 0
            button.isEnabled = true
        }
    }
    @IBAction func lastNameValidator(_ sender: Any) {
        let lastName = validation.valudateLastName(lastName: employeeLastName.text!)
        if (lastName == false) {
            employeeLastName.layer.borderColor = error.cgColor
            employeeLastName.layer.borderWidth = 1.0
            employeeLastName.layer.cornerRadius = 4
            button.isEnabled = false
        }
        else {
            employeeLastName.layer.borderWidth = 0
            button.isEnabled = true
        }
    }
    @IBAction func phoneNumberaValidator(_ sender: Any) {
        let phoneNumber = validation.valudatePhoneNumber(phoneNumber: employeePhoneNumber.text!)
        if (phoneNumber == false) {
            employeePhoneNumber.layer.borderColor = error.cgColor
            employeePhoneNumber.layer.borderWidth = 1.0
            employeePhoneNumber.layer.cornerRadius = 4
            button.isEnabled = false
        }
        else {
            employeePhoneNumber.layer.borderWidth = 0
            button.isEnabled = true
        }
    }
    
    
    @IBAction func submitEmployeeButton(_ sender: UIButton) {
        printEmployee()
        addEmployee()
        employeeEmail.text = ""
        employeeFirstName.text = ""
        employeeLastName.text = ""
        employeePhoneNumber.text = ""
    }
    
    func printEmployee() {
        var active = ""
        if employeeActiveSwitch.isOn {
            active = "Y"
        }
        else {
            active = "N"
        }
        print("Email: \(employeeEmail.text!) \nFirst Name: \(employeeFirstName.text!) \nLast Name: \(employeeLastName.text!) \nPhone Number: \(employeePhoneNumber.text!) \nActive: " + active)
    }
    
    func addEmployee() {
        var active = ""
        if employeeActiveSwitch.isOn {
            active = "Y"
        }
        else {
            active = "N"
        }
        
        let url = NSURL(string: "http://cgi.soic.indiana.edu/~rojbarne/addEmployee.php")

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = ""

        dataString = dataString + "&email=\(employeeEmail.text!)"
        dataString = dataString + "&first_name=\(employeeFirstName.text!)"
        dataString = dataString + "&last_name=\(employeeLastName.text!)"
        dataString = dataString + "&phone=\(employeePhoneNumber.text!)"
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
                            print("Employee Add")
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

