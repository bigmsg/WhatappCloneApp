//
//  ContentView.swift
//  WhatappCloneApp
//
//  Created by 관리자 on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Your username", text: $username).padding()
                
                TextField("Enter password", text: $password).padding()
                HStack {
                    Button(action: {
                        
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
