//
//  ValidationModel.swift
//  timeTracking
//
//  Created by Robbie Barnes on 5/12/20.
//  Copyright © 2020 Robbie Barnes. All rights reserved.
//

import Foundation

class ValidationModel {
    
    public func validateEmail(email: String) -> Bool {
        // Checking to see if it matches this format --> test@gmail.com
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    public func valudateFirstName(firstName: String) -> Bool {
        // Checkes to see if all are english letters and name should be between 2 - 20 letters
        let firstNameRegex = "[A-Za-z]{2,20}$"
        let trimmedString = firstName.trimmingCharacters(in: .whitespaces)
        let validateFirstName = NSPredicate(format: "SELF MATCHES %@", firstNameRegex)
        let isValidateFirstName = validateFirstName.evaluate(with: trimmedString)
        return isValidateFirstName
    }
    
    public func valudateLastName(lastName: String) -> Bool {
        // Checkes to see if all are english letters and name should be between 2 - 20 letters
        let lastNameRegex = "[A-Za-z]{2,20}$"
        let trimmedString = lastName.trimmingCharacters(in: .whitespaces)
        let validateLastName = NSPredicate(format: "SELF MATCHES %@", lastNameRegex)
        let isValidateLastName = validateLastName.evaluate(with: trimmedString)
        return isValidateLastName
    }
    
    public func valudatePhoneNumber(phoneNumber: String) -> Bool {
        // Checks to see if it is a valid phone number 
        let phoneNumberRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    
    
}
