//
//  CreateUser.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/13/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

class CreateUser: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var NewPassFail: Bool = false
    
    func SignUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}
