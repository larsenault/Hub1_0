//
//  UserInfo.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/17/20.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class UserData: ObservableObject {
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
        func GetUser(FirstName: String, LastName: String, Location: String){
            let db = Firebase.Firestore()
        }
}
