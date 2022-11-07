//
//  ForgotPasswordView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//
// 

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    
    
    // String State for user input
    @State private var email: String = ""
    
    @State var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @State var isSendLinkFailedAlert = false
    @State var isSendLinkSuccessfulAlert = false
    
    // to change view
    @EnvironmentObject var viewRouter: ViewRouter
    
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
            // Email
            TextField("Enter email ...", text: $email)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .padding()
            // Send link
            Button {
                self.sendResetPasswordLink(email: email)
            } label: {
                Text("Send link")
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.blue)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            // Sign-in
            Button("Back to Sign-In") {
                withAnimation {
                    viewRouter.currentView = .pageSignInView
                }
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
    // send link to user email address
    func sendResetPasswordLink(email: String){
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
