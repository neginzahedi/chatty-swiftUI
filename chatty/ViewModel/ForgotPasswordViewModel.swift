//
//  ForgotPasswordViewModel.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-14.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var alertMessage: String = ""
    
    // Boolean state that determines whether the alert should be visible
    @Published var isSendLinkFailedAlert = false
    @Published var isSendLinkSuccessfulAlert = false
    
    
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
