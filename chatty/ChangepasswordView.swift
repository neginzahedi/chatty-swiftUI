//
//  ChangepasswordView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-09.
//

import SwiftUI

struct ChangepasswordView: View {
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var newPasswordAgain: String = ""
    
    
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
        .navigationBarItems(trailing: Text("Save"))
        
    }
    
}

struct ChangepasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangepasswordView()
    }
}
