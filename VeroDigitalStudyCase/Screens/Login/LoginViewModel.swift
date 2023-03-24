//
//  LoginViewModel.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

protocol LoginViewModelInterface:AnyObject {
    var view:LoginViewInterface?{get set}
    
    func viewDidLoad()
}


class LoginViewModel {
    var view:LoginViewInterface?
    private let authManager : AuthManager?
    
    init(view:LoginViewInterface,authManager:AuthManager=AuthManager.shared) {
        self.view = view
        self.authManager = authManager
    }
}


extension LoginViewModel:LoginViewModelInterface {
    
    func viewDidLoad() {
        view?.layout()
        view?.style()
    }
    
    
    
    
}
