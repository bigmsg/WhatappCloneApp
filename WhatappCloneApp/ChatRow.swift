//
//  ChatRow.swift
//  WhatappCloneApp
//
//  Created by 관리자 on 2019/11/23.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI
import Firebase
import URLImage

struct ChatRow: View {
    var currentUserFromhomeWeAreChattingTo: UserModel?
    var ChatMessageData: ChatModel?
    var body: some View {
        Group {
            //Text("hello")
            VStack(alignment: .leading) {
                Text("from: \(ChatMessageData!.from)")
                Text("to: \(ChatMessageData!.to)")
                Text("message: \(ChatMessageData!.message)")
            }
            
            // to: me && from: 상대방
            if ChatMessageData?.to == Auth.auth().currentUser?.uid &&
                ChatMessageData?.from == currentUserFromhomeWeAreChattingTo?.uidFromFirebase {
                
                    HStack {
                        //Spacer()
                        if ChatMessageData?.type != "Image" {
                            Text(ChatMessageData!.message)
                                .bold()
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        } else {
                            //Image(systemName: "photo")
                            URLImage(URL(string: ChatMessageData!.message)!, content: { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            }).frame(width: 200, height: 200)
                        }
                            
                        Spacer()
                    }

            }
            
            // from: me && to: 상대방,
            else if ChatMessageData?.from == Auth.auth().currentUser?.uid &&
                ChatMessageData?.to == currentUserFromhomeWeAreChattingTo?.uidFromFirebase {
                HStack {
                    Spacer()
                    if ChatMessageData?.type != "Image" {
                        Text(ChatMessageData!.message).bold()
                            .padding(10)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    } else {
                        //Image(systemName: "photo")
                        URLImage(URL(string: ChatMessageData!.message)!,  content: { proxy in
                            proxy.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }).frame(width: 200, height: 100)
                    }
                    
                }
            }
                

        }.frame(width: UIScreen.main.bounds.width * 0.90)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(currentUserFromhomeWeAreChattingTo: UserModel(id: 1, username: "ads", uidFromFirebase: "adasd"), ChatMessageData: ChatModel(id: 1, message: "Good", uidFromFirebase: "hello", from: "bigmsgo@naver.com", to: "hello@naver.com", date: Date(), type: "uouo", messageFromMe: true))
    }
}
