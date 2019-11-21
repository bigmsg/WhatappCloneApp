//
//  userModel.swift
//  WhatappCloneApp
//
//  Created by 양팀장(iMac) on 2019/11/21.
//  Copyright © 2019 관리자. All rights reserved.
//

import Foundation

struct UserModel: Identifiable {
    
    var id: Int
    var username: String
    var uidFromFirebase: String
    
}
