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
    
    // to dismiss current view
    @Environment(\.presentationMode) var presentationMode
    
    // String State for user input
    @State private var email: String = ""
    
    @ObservedObject var vm = ForgotPasswordViewModel()
    
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
                vm.sendResetPasswordLink(email: email)
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
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.gray)
        }
        
        // Alerts:
        // alert when faild to send link
        .alert(vm.alertMessage, isPresented: $vm.isSendLinkFailedAlert) {
            Button("Ok", role: .cancel) {}
        }
        // alert when link sent
        .alert(vm.alertMessage, isPresented: $vm.isSendLinkSuccessfulAlert) {
            Button("Ok", role: .cancel) {}
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
