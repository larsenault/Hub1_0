//
//  SuccessLogin.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/14/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SuccessLogin: View {
    
    

    /*func signout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }*/
    
    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      }.frame(width: 426, height: 800) //frame dimensions for a Iphone 12 pro max
   }


struct SuccessLogin_Previews: PreviewProvider {
    static var previews: some View {
        SuccessLogin()
    }
}
}
