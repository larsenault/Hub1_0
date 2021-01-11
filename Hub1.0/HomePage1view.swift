//
//  HomePage1.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/16/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct HomePage1view: View {
    @State var Fname: String = ""
    @State var Lname: String = ""
    @State var Location: String = ""
    @State var HomePage1: Bool = false
    @State var MainPage: Bool = false
    
    func upload(){
        let db = Firestore.firestore()
        db.collection("HUBdata").document(Auth.auth().currentUser!.uid).setData(["FirstName": Fname,"LastName": Lname,"Location": Location])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: true")
            }
        }
    }
    
    var body: some View {
        ZStack {
            Text("My name is HUB! It is nice to meet you. Tell me a little bit about yourself...")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30))
                .offset(y: -350)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("What is your first name?")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30))
                .padding(.trailing, 80)
                .offset(y: -200)
            FnameTextField(Fname: $Fname)
                .offset(y: -130)
                .padding()
            
            Text("What is your Last name?")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30))
                .padding(.trailing, 75)
                .offset(y: -60)
            LnameTextField(Lname: $Lname)
                .offset(y: 10)
                .padding()
            
            Text("Where are you located?")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30))
                .padding(.trailing, 80)
                .offset(y: 77)
            LocationTextField(Location: $Location)
                .offset(y: 150)
                .padding()
            Text("Your location will NOT be used to track you in any way, I am not a corporation.")
                .offset(y: 200)
                .multilineTextAlignment(.center)
                .padding()
            VStack {
                Spacer(minLength: 650)
                Button(action: {
                        upload()
                        self.MainPage.toggle()
                        }, label: {
                            if(Fname.isEmpty || Lname.isEmpty || Location.isEmpty){
                                WelcomeButton(isPresented: $HomePage1).opacity(0)
                            }else{
                                WelcomeButton(isPresented: $HomePage1).opacity(1)
                                
                            }
                        }).fullScreenCover(isPresented: $MainPage, content: {
                            SuccessLogin()
                        })
        
            }.frame(width: 300, height: 200)
    }.frame(width: 426, height: 800) //frame dimensions for a Iphone 12 pro max
       
}

struct HomePage1view_Previews: PreviewProvider {
    static var previews: some View {
        HomePage1view()
    }
}

struct FnameTextField: View {  //First name default content
    @Binding var Fname: String
    var body: some View {
        TextField("Enter your first name", text: $Fname)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct LnameTextField: View {  //Last name default content
    @Binding var Lname: String
    var body: some View {
        TextField("Enter your last name", text: $Lname)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct LocationTextField: View {  //Location default content
    @Binding var Location: String
    var body: some View {
        TextField("Enter your location (Manchester, ME)", text: $Location)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct WelcomeButton: View {  //Button to go to welcome screen
    @Binding var isPresented: Bool
    var body: some View {
          Text("Come on in!")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
      }
   }
}
