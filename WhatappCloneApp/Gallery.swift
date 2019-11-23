//
//  Gallery.swift
//  WhatappCloneApp
//
//  Created by 관리자 on 2019/11/23.
//  Copyright © 2019 관리자. All rights reserved.
//


import Foundation
import SwiftUI
import Firebase

struct OpenGallary: UIViewControllerRepresentable {

let isShown: Binding<Bool>
let image: Binding<UIImage?>
    let userToChat:UserModel

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let isShown: Binding<Bool>
    let image: Binding<UIImage?>
    var db = Firestore.firestore()
    let userToChat: UserModel

    init(isShown: Binding<Bool>, image: Binding<UIImage?>,userToChat:UserModel) {
        self.isShown = isShown
        self.image = image
        self.userToChat=userToChat
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //self.image.wrappedValue = Image(uiImage: uiImage)
        self.isShown.wrappedValue = false
        
        
        var ref :DocumentReference? = nil
               
               let storage = Storage.storage()
                          let storageRef = storage.reference()
                          
                          
                          let mediaFolder = storageRef.child("images")
                          
                          
               if let data = uiImage.jpegData(compressionQuality: 0.5)
                          {
                              let imageRef = mediaFolder.child("\(UUID()).jpeg")
                              imageRef.putData(data, metadata: nil){
                                  (metaData,error) in
                                  if error != nil
                                  {
                                      print(error?.localizedDescription)
                                      print("error in uploading image")
                                  }
                                  else
                                  {
                                      imageRef.downloadURL { (url, error) in
                                          if error == nil
                                          {
                                              let url_String = url?.absoluteString
                                              

                                          let chatData: [String:Any] = [
                                              "from":Auth.auth().currentUser?.uid,"To":self.userToChat.uidFromFirebase,
                                              "date":Date(),"message":url_String,"type":"Image"
                                          ]
                                              
                                              ref = self.db.collection("chats").addDocument(data: chatData, completion: { (err) in
                                                         if err != nil
                                                         {
                                                             print(err?.localizedDescription)
                                                             print("Error in sending the Message to the DB")
                                                         }
                                                         else
                                                         {
                                                            // self.messageToSend=""
                                                           print("Image Posted")
                                                         }
                                                     })
                                          
                                          }
                                      }
                                  }
                              }
                          }
               
        
        
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown.wrappedValue = false
    }

}

func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: isShown, image: image,userToChat: userToChat)
}

func makeUIViewController(context: UIViewControllerRepresentableContext<OpenGallary>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
}

func updateUIViewController(_ uiViewController: UIImagePickerController,
                            context: UIViewControllerRepresentableContext<OpenGallary>) {

}

}

