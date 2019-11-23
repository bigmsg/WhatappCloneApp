//
//  ChatStore.swift
//  WhatappCloneApp
//
//  Created by 관리자 on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//


import Foundation
import SwiftUI
import Combine
import Firebase

class ChatStore: ObservableObject {
    
    let db = Firestore.firestore()
    var chatArray: [ChatModel] = []
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        
        // chat from me
        db.collection("chats").whereField("from", isEqualTo: Auth.auth().currentUser?.uid)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Error in Fetching the chats data from the firebase")
                print(error?.localizedDescription)
            } else {
                self.chatArray.removeAll()
                for doc in snapshot!.documents {
                    let chatUIDfromFirebase = doc.documentID
                    
                    if let message = doc.get("message") as? String {
                      if let from = doc.get("from") as? String {
                        if let to = doc.get("To") as? String {
                          if let type = doc.get("type") as? String {
                            if let dateString = doc.get("date") as? Timestamp {

                                let dateformDb = dateString.dateValue()
                                let currentIndex = self.chatArray.last?.id
                                let newChat = ChatModel(id: (currentIndex ?? -1) + 1, message: message, uidFromFirebase: chatUIDfromFirebase, from: from, to: to, date: dateformDb, type: type, messageFromMe: true)
                                
                                self.chatArray.append(newChat)
                                
                            }
                          }
                        }
                      }
                    }
                } // for
                
                print(self.chatArray)
                self.didChange.send(self.chatArray)
                
                
            }
        }
        
        // chat to me
        db.collection("chats").whereField("To", isEqualTo: Auth.auth().currentUser?.uid)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Error in Fetching the chats data from the firebase")
                print(error?.localizedDescription)
            } else {
                //self.chatArray.removeAll()
                for doc in snapshot!.documents {
                    let chatUIDfromFirebase = doc.documentID
                    
                    if let message = doc.get("message") as? String {
                      if let from = doc.get("from") as? String {
                        if let to = doc.get("To") as? String {
                          if let type = doc.get("type") as? String {
                            if let dateString = doc.get("date") as? Timestamp {

                                let dateformDb = dateString.dateValue()
                                let currentIndex = self.chatArray.last?.id
                                let newChat = ChatModel(id: (currentIndex ?? -1) + 1, message: message, uidFromFirebase: chatUIDfromFirebase, from: from, to: to, date: dateformDb, type: type, messageFromMe: true)
                                
                                self.chatArray.append(newChat)
                                
                            }
                          }
                        }
                      }
                    }
                } // for
                
                print(self.chatArray)
                self.chatArray = self.chatArray.sorted(by: {
                    $0.date.compare($1.date) == .orderedAscending
                })
                self.didChange.send(self.chatArray)
                
                
            }
        }
        
    }
}

