//
//  ForgotPasswordView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//
// TODO: reset password link works but goes to spam right now

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    
    // to dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    // String State for user input
    @State private var email: String = ""
    
    @State private var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State private var isSendLinkFailedAlert = false
    @State private var isSendLinkSuccessfulAlert = false
    
    var body: some View {
        
        VStack{
            
            Image("question")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            Text("Did someone forget their password?")
                .fontWeight(.heavy)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Thats ok! Enter your email and we will send you a link to reset your password.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
            
            // Text Field: Email
            TextField("Enter email ...", text: $email)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            // Button: to send Reset Password link
            Button("Send", action: sendResetPasswordLink)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            
            Button("Back to Sign-In") {
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.gray)
            
        }
        
        // Alerts:
        // alert when faild to send link
        .alert(alertMessage, isPresented: $isSendLinkFailedAlert) {
            Button("Ok", role: .cancel) {}
        }
        // alert when link sent
        .alert(alertMessage, isPresented: $isSendLinkSuccessfulAlert) {
            Button("Ok", role: .cancel) {}
        }
    }
    
    //TODO: reset password link works but goes to spam right now
    // sendPasswordReset method of Firebase,send reset password link to user email address
    private func sendResetPasswordLink(){
        FirebaseManager.shared.auth.sendPasswordReset(withEmail: email) { error in
            if let e = error{
                self.alertMessage = e.localizedDescription
                self.isSendLinkFailedAlert = true
            }
            else{
                self.alertMessage = "Reset password link is sent to the \(email)"
                self.isSendLinkSuccessfulAlert = true
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
