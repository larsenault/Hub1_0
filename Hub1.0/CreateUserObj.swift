//
//  CreatUserObj.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/17/20.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class CurrentUserObj: ObservableObject {
    func SignUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: emailObj.email, password: self.password) { (result, error) in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.alert = true
            }else{
                if result != nil{
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


