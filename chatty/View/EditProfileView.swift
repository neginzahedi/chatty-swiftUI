//
//  EditProfileView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-05.
//
// EditProfileView: cuurent user can check saved info, change them and delete account.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditProfileView: View {
    
    // view model to fetch current user info
    @ObservedObject var vm = MainViewModel()
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var status: String = ""
    
    @State var shouldShowImagePicker = false
    @State var isDeleteAccountClicked = false
    
    @State var img: UIImage?
    
    // To change current view
    @EnvironmentObject var viewRouter: ViewRouter
    
    let const = Constant()
    
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
                        if vm.currentUser?.profileImageUrl == ""{
                            Image("profile")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .cornerRadius(150)
                        } else {
                            WebImage(url: URL(string: vm.currentUser?.profileImageUrl ?? "profile"))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .cornerRadius(150)
                        }
                    }
                }
            }.padding()
            
            List{
                // TODO: change user info
                Section{
                    NavigationLink {
                        ChangeUsernameView(vm: self.vm)
                    } label: {
                        Text(vm.currentUser?.username ?? "username")
                    }
                } header: {
                    Text("username")
                }
                
                Section{
                    NavigationLink {
                        ChangeStatusView(vm: self.vm)
                    } label: {
                        Text(vm.currentUser?.status ?? "status")
                    }
                } header: {
                    Text("Status")
                }
                
                // Password Section: navigates to ChangepasswordView
                Section{
                    NavigationLink {
                        ChangepasswordView()
                    } label: {
                        Text("Change Password")
                    }
                    // delete account
                    Button {
                        isDeleteAccountClicked.toggle()
                    } label: {
                        Text("Delete Account")
                            .foregroundColor(.red)
                    }
                } // password section
            }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationTitle("Edit Profile").navigationBarTitleDisplayMode(.inline)
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
        // actionSheet: confirm delete account
        .actionSheet(isPresented: $isDeleteAccountClicked) {
            .init(title: Text("Delete Account"), message: Text("Are you sure you want to delete your account permenantly?"), buttons: [
                .destructive(Text("Delete"), action: {
                    deleteUser()
                }),
                .cancel()
            ])
        }
        // fullScreenCover
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $img )
        }
        //        .onAppear(){
        //            self.vm.fetchCurrentUser()
        //        }
    }
    
    // TODO: ask to sign in again
    // TODO: remove user from Firestore DB
    func deleteUser() {
        let user = FirebaseManager.shared.auth.currentUser
        let userID = FirebaseManager.shared.auth.currentUser?.uid ?? ""
        let username = vm.currentUser?.username ?? ""
        user?.delete { error in
            if let error = error {
                print(error)
            } else {
                print("Account deleted.")
                // users DB
                FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(userID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
                
                // username_id DB
                FirebaseManager.shared.firestoreDB.collection(const.collection_usernames).document(username).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                        withAnimation {
                            self.viewRouter.currentView = .pageWelcomeView
                        }
                    }
                }
            }
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
        
        FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(userID).updateData([
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
    
    func saveUsername(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else {
            print("user not found")
            return
        }
        
        if username.isEmpty {
            print("no new username")
        } else {
            FirebaseManager.shared.firestoreDB.collection(const.collection_users).document(userID).updateData([
                "username" : self.username
            ]) { error in
                if let e = error {
                    print(e)
                    return
                }
                else{
                    print("username updated")
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
