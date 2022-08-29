//
//  EditProfileView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// EditProfileView contains user's saved name, email address, status and Password which can be changed as well.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditProfileView: View {
    
    @ObservedObject var vm = MainViewModel()
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var status: String = ""
    
    @State var shouldShowImagePicker = false
    
    @State var img: UIImage?
    
    var body: some View {
        VStack{
            Button {
                shouldShowImagePicker.toggle()
            } label: {
                VStack{
                    if let image = self.img{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300, alignment: .center)
                            .cornerRadius(150)
                        //.clipped() - square
                        
                    }else{
                        WebImage(url: URL(string: vm.currentUser?.profileImageUrl ?? "profileImageURL" ))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .cornerRadius(150)
                    }
                }
            }
            List{
                // TODO: change user info
                Section{
                    HStack{
                        Text("Username")
                        Spacer()
                        Spacer()
                        TextField(vm.currentUser?.username ?? "username", text: $name)
                    }
                    HStack{
                        Text("Status")
                        Spacer()
                        Spacer()
                        TextField(vm.currentUser?.status ?? "status", text: $status)
                    }
                }
                
                // Password Section: navigates to ChangepasswordView
                Section{
                    NavigationLink {
                        ChangepasswordView()
                    } label: {
                        Text("Password")
                    }
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Delete Account")
                    }
                    
                }
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Edit Profile")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.saveImageToFirestore()
                        } label: {
                            Text("Save")
                        }
                    }
                }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $img )
        }
        .onAppear(){
            self.vm.fetchCurrentUser()
        }
    }
    
    func saveImageToFirestore(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {return}
        guard let imageData = self.img?.jpegData(compressionQuality: 0.5) else {return}
        
        FirebaseManager.shared.storage.reference(withPath: userID).putData(imageData, metadata: nil){
            metadata, error in
            if let e = error {
                print("faild to save image \(e)")
                return
            }
            FirebaseManager.shared.storage.reference(withPath: userID).downloadURL { url, error in
                if let e = error {
                    print("faild to retrive downloadurl \(e)")
                    return
                }
                print("retrive successfully: \(url?.absoluteString ?? "url")")
                
                guard let url = url else {return}
                self.storeUserInformation(userProfileImageURL : url)
            }
        }
    }
    
    func storeUserInformation(userProfileImageURL: URL){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {
            print("user not found")
            return
        }
        
        FirebaseManager.shared.firestoreDB.collection("registeredUsers").document(userID).updateData([
            "profileImageURL" : userProfileImageURL.absoluteString
        ]) { error in
            if let e = error {
                print(e)
                return
            }
            else{
                print("image saved to db")
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
