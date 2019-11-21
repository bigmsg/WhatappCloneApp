//
//  UserStore.swift
//  WhatappCloneApp
//
//  Created by 양팀장(iMac) on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class UserStore: ObservableObject {
    
    let db = Firestore.firestore()
    var userArray: [UserModel] = []
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        db.collection("Users").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Error in Fetching the user data from the firebase")
                print(error?.localizedDescription)
            } else {
                self.userArray.removeAll()
                for doc in snapshot!.documents {
                    if let userIDfromFirebase = doc.get("userIDfromFirebase") as? String {
                        if let username = doc.get("username") as? String {
                            let currentIndex = self.userArray.last?.id
                            
                            let user = UserModel(id: (currentIndex ?? -1)+1, username: username, uidFromFirebase: userIDfromFirebase)
                            
                            self.userArray.append(user)
                        }
                    }
                }
                
                self.didChange.send(self.userArray)
                
                
            }
        }
    }
}
