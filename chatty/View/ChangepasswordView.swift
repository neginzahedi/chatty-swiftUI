//
//  ChangepasswordView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//
// ChangepasswordView: user can change the password.
//


import SwiftUI
import FirebaseAuth
struct ChangepasswordView: View {
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var newPasswordAgain: String = ""
    
    //    let user = FirebaseManager.shared.auth.currentUser
    //    var credential: AuthCredential
    
    
    var body: some View {
        VStack{
            Text("A secure password must be at least six characters and a combination of letters, numbers and special symbols.")
                .foregroundColor(.gray)
                .padding()
            Spacer()
            List{
                TextField("Enter Current Password", text: $currentPassword)
                TextField("Enter New Password", text: $newPassword)
                TextField("Enter New Password Again", text: $newPasswordAgain)
            }
        }
        
        .navigationBarTitle(Text("Change Password"), displayMode: .inline)
        // TODO: change to toolbar
        .navigationBarItems(trailing: Text("Save"))
        
    }
    
    // TODO: change password is not working
    private func changePassword(){
        // check if current password is correct
        // Prompt the user to re-provide their sign-in credentials
        
        /*
         user?.reauthenticate(with: credential) { error,arg  in
         if let error = error {
         // An error happened.
         } else {
         // User re-authenticated.
         }
         }
         // check if new pass and new pass again is same
         // chamge password
         FirebaseManager.shared.auth.currentUser?.updatePassword(to: newPassword){ error in
         */
    }
}


struct ChangepasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangepasswordView()
    }
}
