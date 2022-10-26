//
//  MotherView.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-26.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    // change current view based on user's activity
    var body: some View {
        switch viewRouter.currentView {
        case .pageWelcomeView:
            WelcomeView()
        case .pageSignInView:
            SignInView()
        case .pageSignUpView:
            SignUpView()
        case .pageForgotPasswordView:
            ForgotPasswordView()
        case .pageMainView:
            MainView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
