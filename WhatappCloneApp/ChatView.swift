//
//  chatView.swift
//  WhatappCloneApp
//
//  Created by 양팀장(iMac) on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatView: View {
    
    var currentUserID = Auth.auth().currentUser?.uid ?? "not login"
    var userToChat: UserModel
    var db = Firestore.firestore()
    @State var messageToSend = ""
    @State var chatMessageType = ""
    @State var imageData: UIImage?
    @State var showImagePicker: Bool = false
    
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("currentUID: \(Auth.auth().currentUser?.uid ?? "not login")")
                Text("bigmsg: Viu0455TdJcQsECercwCtMl19Nd2")
                Text("hickman: RJNhvU608lYQ2W9OBaSCIMteY112")
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Divider()
            
            ScrollView {
                ForEach(chatStore.chatArray) { chat in
                    ChatRow(currentUserFromhomeWeAreChattingTo: self.userToChat, ChatMessageData: chat)
                }
            }
            
            /*List(chatStore.chatArray) { chat in
                ChatRow(currentUserFromhomeWeAreChattingTo: self.userToChat, ChatMessageData: chat)

            }*/
            HStack {
                
                // 이미지첨부
                Button(action: {
                    withAnimation {
                        self.showImagePicker.toggle()
                        //print("hello")
                    }
                }){
                    Image(systemName: "paperclip").imageScale(.large)
                }
                
                TextField("Enter Your Message", text: $messageToSend).frame(minHeight: 40)

                // send message
                Button(action: {
                    self.sendMessageToFirebase(type: "T")

                }){
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }



                Button(action: {
                    self.sendMessageToFirebase(type: "TH")
                }){
                    Image(systemName: "hand.thumbsup")
                        .imageScale(.large)
                }


                //Text(userToChat.username)
            }.frame(minHeight: 50).padding()
            
            if showImagePicker {
                OpenGallary(isShown: $showImagePicker, image: $imageData, userToChat: userToChat)
            }
            
        }
    }
    
    func sendMessageToFirebase(type: String) {
        var ref: DocumentReference? = nil
        
        
        if type == "Image" {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            let mediaFolder = storageRef.child("images")
            
            if let data = imageData?.jpegData(compressionQuality: 0.5) {
                let imageRef = mediaFolder.child("\(UUID()).jpeg")
                imageRef.putData(data, metadata: nil) { (metaData, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        print("Error in uploading image")
                    } else {
                        imageRef.downloadURL{ (url, error) in
                            if error == nil {
                                let url_String = url?.absoluteString
                                
                                let chatData: [String:Any] = [
                                    "from": Auth.auth().currentUser?.uid,
                                    "To": self.userToChat.uidFromFirebase,
                                    "date": Date(),
                                    "message": url_String,
                                    "type": type
                                ]
                                    
                                ref = self.db.collection("chats").addDocument(data: chatData, completion: { error in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                        print("Error in sending the Message to the DB")
                                    } else {
                                        self.messageToSend = ""
                                    }
                                    
                                })
                                
                            }
                        }
                    }
                }
                
            }
            
            
            
            
            
        } else {
            let chatData: [String:Any] = [
                "from": Auth.auth().currentUser?.uid,
                "To": userToChat.uidFromFirebase,
                "date": Date(),
                "message": (type == "T") ? self.messageToSend : "👍",
                "type": type
            ]
                
            ref = self.db.collection("chats").addDocument(data: chatData, completion: { error in
                if error != nil {
                    print(error?.localizedDescription)
                    print("Error in sending the Message to the DB")
                } else {
                    self.messageToSend = ""
                }
                
            })
        }

    }
}

struct chatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(id: 1, username: "John", uidFromFirebase: "123412332"))
    }
}
