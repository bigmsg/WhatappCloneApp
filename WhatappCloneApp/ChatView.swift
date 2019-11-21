//
//  chatView.swift
//  WhatappCloneApp
//
//  Created by 양팀장(iMac) on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    var userToChat: UserModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct chatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(id: 1, username: "John", uidFromFirebase: "123412332"))
    }
}
