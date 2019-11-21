//
//  ListView.swift
//  WhatappCloneApp
//
//  Created by 양팀장(iMac) on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI
import Firebase

struct UserListView: View {
    var body: some View {
        NavigationView {
            List {
                Text("User View")
                
                
            }.navigationBarTitle("WhatsApp Clone")
            .navigationBarItems(trailing: Button(action: {
                
                
                }){
                    Text("Log Out")
                })
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
