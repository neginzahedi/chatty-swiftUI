//
//  ViewRouter.swift
//  chatty
//
//  Created by Negin Zahedi on 2022-10-26.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var currentView: PageView
    
    // if user is already signed-in, display mainView(), otherwise welcomeView()
    init(){
        if FirebaseManager.shared.auth.currentUser != nil{
            currentView = PageView.pageMainView
        } else{
            currentView = PageView.pageWelcomeView
        }
    }
    
}

enum PageView {
    case pageWelcomeView
    case pageMainView
    case pageSignInView
    case pageSignUpView
    case pageForgotPasswordView
}
