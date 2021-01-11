//
//  Register.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/13/20.
//
// REGISTER PAGE FOR HUB APP

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var NewPassFail: Bool = false
    @State var newPage1: Bool = false
    @State var errorMessage = ""
    @State var alert = false
    
    @Environment(\.presentationMode) var presentationMode  //Property Wrapper: The presentation mode of a view contains only two pieces of data, but both are useful: a property storing whether the view is currently presented on screen, and a method to let us dismiss the view immediately.
    @ObservedObject var emailObj = EmailValidationObj()

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

    var body: some View {
        ZStack{
            Text("Create your new account 👍🏼")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30))
                .offset(y: -300)
                .font(.largeTitle)
             
            Text("Enter email:")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.trailing, 220)
                .offset(y: -200)
            EmailTextField(email: $emailObj.email)  //Talks with down below
                .offset(y: -130)
                .offset(x: -4)
                .padding()
            Text("Create a password \n(6 or more characters, NO spaces)")
                .font(.system(size: 25))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.trailing, 5)
                .offset(y: -50)
                .offset(x: -1)
            PasswordSecureField(password: $password)  //Talks with down below
                .offset(y: 35)
                .offset(x: -4)
                .padding()
            
            if NewPassFail{  //Check to make sure password is up to standards
                Text("Password is invalid or missing")
                .foregroundColor(.red)
                .offset(y: 160)
                .animation(Animation.default)
            }
            Text(emailObj.error).foregroundColor(.red).animation(Animation.default).offset(y: 130)
            
            VStack{
            Spacer(minLength: 500)
            Button(action: {  //Submit button to create new account
                if(self.password.isEmpty || self.password.count < 6 || self.password.contains(" ")){
                    self.NewPassFail = true
                }else{
                    SignUp(email: emailObj.email, password: password)
                    self.NewPassFail = false
                }
            }) {
                NewAccountButton(isPresented: $newPage1)
            }.alert(isPresented: $alert, content: {
                Alert(title: Text("well that didn't work...").foregroundColor(.red).fontWeight(.heavy), message: Text(self.errorMessage), dismissButton: .default(Text("Do better")))
            })
          }.frame(width: 300, height: 200)
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct EmailTextField: View {  //Email default content
    @Binding var email: String
    var body: some View {
        TextField("Enter your email", text: $email)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {  //Password default content
    @Binding var password: String
    var body: some View {
        SecureField("Enter your password", text: $password)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct NewAccountButton: View {  //Button to submit new account
    @Binding var isPresented: Bool
    var body: some View {
        Text("SUBMIT")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}
