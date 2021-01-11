//
//  ContentView.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/13/20.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var newPage1 = false  //Registration page
    @State var HomePage1: Bool = false  //Successful login page
    @State var NewPassFail: Bool = false
    @State var errorMessage = ""
    @State var alert = false
    @State var User = false
    @State var action: Bool = false
    @State var successPage: Bool = false
    
    @ObservedObject var emailObj = EmailValidationObj()
    

    func signin(email: String, password: String) {
        Auth.auth().signIn(withEmail: emailObj.email, password: self.password) { (result, error) in
            if let error = error{
                self.errorMessage = error.localizedDescription
                self.alert = true
 
        let db = Firestore.firestore()
        let check = db.collection("HUBdata").document(Auth.auth().currentUser!.uid)
        check.getDocument { (document, error)
            in if let document = document, document.exists {
                self.successPage.toggle()
                print("document does exist")
                let doc = document.data()
                print(doc!)
            }else {
                print("document does not exist")
                self.HomePage1.toggle()
                print("document does exist")
                
            }
          }
        }
      }
    }
    
    
    
    var body: some View {
        VStack{
            WelcomeText()
            HomeScreenPic()
            EmailTextField(email: $emailObj.email)
                .offset(y: -30)
                .padding()
            PasswordSecureField(password: $password)
                .offset(y: -50)
                .padding()
            if NewPassFail{  //Check to make sure password is up to standards
                Text("Password is Invalid")
                .foregroundColor(.red)
                .offset(y: -20)
                .animation(Animation.default)
            }
            Text(emailObj.error).foregroundColor(.red).animation(Animation.default).offset(y: -10)
            
            
            Button(action: {
                signin(email: email, password: password)
                if(self.password.isEmpty || self.password.count < 6 || self.password.contains(" ")){
                    self.NewPassFail = true
                }else{
                    self.NewPassFail = false
                }
            }) {
                LoginButtonContent()
            }.background(EmptyView().fullScreenCover(isPresented: $HomePage1, content: {
                HomePage1view()
            })).background(EmptyView().fullScreenCover(isPresented: $successPage, content: {
                SuccessLogin()
            })).alert(isPresented: $alert, content: {
                Alert(title: Text("well that didn't work...").foregroundColor(.red).fontWeight(.heavy), message: Text(self.errorMessage), dismissButton: .default(Text("Do better")))
                    })
            Button(action: {  //Goes to create a new account
                self.newPage1 = true
            }) {
                NewAccountButton0()
            }.sheet(isPresented: $newPage1, content: {
                RegisterView()
            })
            
        }
       
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome to HUB \n please login below!")
            .fontWeight(.semibold)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding(.bottom, 10)
            .frame(width: 390, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct HomeScreenPic: View {
    var body: some View {
        Image("HomeImage")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct NewAccountButton0: View {
    var body: some View {
        Text("Don't have an account? Create one here!")
            .font(.headline)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .offset(y: 10)
    }
}

}



