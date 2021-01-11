//
//  EmailVerification.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/14/20.
//

import Foundation
import SwiftUI

class EmailValidationObj: ObservableObject {
    @Published var email = "" {
        didSet {
            if self.email.isEmpty {
                self.error = "Email required"
            } else if !self.email.isValidEmail(){
                self.error = "Invalid email"
            } else {
                self.error = ""
            }
        }
    }
    @Published var error = ""
}
    extension String{
func isValidEmail() -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
    return emailValidation.evaluate(with: self)
    }
}
