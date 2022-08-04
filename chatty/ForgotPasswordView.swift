//
//  ForgotPasswordView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-08-04.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""

    var body: some View {

        VStack{
            
            // Image
            Image("question-face")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            // Title
            Text("Did someone forget their password?")
                .fontWeight(.heavy)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            // Text
            Text("Thats ok! Enter your email and we will send you a link to reset your password.")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
            
            // Text Field
            TextField("Enter email ...", text: $email)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .padding()
           
            // Button
            Button("Send", action: sendForgotPasswordLink)
                .frame(width: 200, height: 50, alignment: .center)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
            
            
        }
        
        
    }
    
    // TODO
    private func sendForgotPasswordLink(){
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            
    }
}
