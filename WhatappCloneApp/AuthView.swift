//
//  ContentView.swift
//  WhatappCloneApp
//
//  Created by 관리자 on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI
import Firebase

struct AuthView: View {
    
    @State var username = ""
    @State var password = ""
    
    @State var showAuthView = true
    
    @ObservedObject var userStore = UserStore()
    
    var firestoreDB = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            if showAuthView {
                VStack {
                    TextField("Enter Your username", text: $username).padding().autocapitalization(.none)
                    
                    TextField("Enter password", text: $password).padding()
                    HStack {
                        Button(action: {
                            self.signIn()
                        }){
                            Text("Login")
                                .bold()
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            
                        }){
                            Text("Forget Password")
                                .bold()
                                .padding()
                                .background(Color.red)
                                .foregroundColor(Color.white)
                        }

                        
                    }.frame(width: UIScreen.main.bounds.width * 0.85)
                        .padding(.bottom, 10)
                    
                    //EmptyView.frame(height: 10)
                    
                    HStack {
                        Button(action: {
                            self.signUp()
                        }){
                            Text("Sign Up")
                                .bold()
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.main.bounds.width * 0.60)
                        .background(Color.green)
                    
                    Spacer()
                    Text("Made with 😍 in the course")
                }.navigationBarTitle("WhatsApp")
                
            } else {
                NavigationView {
                    List(userStore.userArray) { user in
                        Text(user.username)
                        NavigationLink(destination: ChatView(userToChat: user)) {
                            Text(user.username)
                        }
                        
                    }.navigationBarTitle("WhatsApp Clone")
                    .navigationBarItems(trailing: Button(action: {
                            do{
                                try Auth.auth().signOut()
                                self.showAuthView = true
                            } catch {
                                print("error in signing out")
                            }
                        
                        }){
                            Text("Log Out")
                        })
                }
            }
            
        }
    }
    
    
    func signIn() {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
                print("Error during login")
            } else {
                self.showAuthView = false
            }
        }
    }
    
    func signUp() {
        // Firebase Auth
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
                print("Error During Signup")
            } else {
                // Allow the user to go to the next viev
                print("User Created")
                var ref : DocumentReference? = nil
                
                var userData: [String: Any] = [
                    "username": self.username,
                    "password": self.password,
                    "userIDfromFirebase": result?.user.uid
                ]
                
                ref = self.firestoreDB.collection("Users").addDocument(data: userData, completion: { error in
                    if error != nil {
                        print(error?.localizedDescription)
                        print("Error in Insertion of the user DB")
                    }
                    else {
                        print("Database insertion done")
                        
                        // User View
                        self.showAuthView = false
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            AuthView(showAuthView: false)
            AuthView(showAuthView: true)
        }
    }
}
