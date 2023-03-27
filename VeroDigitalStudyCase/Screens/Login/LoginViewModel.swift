//
//  LoginViewModel.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation
import ProgressHUD

protocol LoginViewModelInterface:AnyObject {
    var view:LoginViewInterface?{get set}
    func viewDidLoad()
    func login(userName:String,password:String)
}

final class LoginViewModel {
    weak var view:LoginViewInterface?
    private let authManager : AuthManagerInterface?
    
    init(view:LoginViewInterface,authManager:AuthManagerInterface=AuthManager.shared) {
        self.view = view
        self.authManager = authManager
    }
}

extension LoginViewModel:LoginViewModelInterface {
    
    func viewDidLoad() {
        view?.layoutUI()
        view?.styleUI()
        view?.addOberserverKeyboard()
        
    }
    
    func login(userName: String, password: String) {
        
        let parameters = ["username": userName,"password": password] as [String : String]
        
        authManager?.login(parameters: parameters, completion: { result in
            switch result {
            case .success(let authResponse):
                self.authManager?.saveToken(result: authResponse)
                self.view?.pushToMainVC()
            case .failure(let error):
                ProgressHUD.showFailed(error.localizedDescription)
            }
        })
        
    }
    
    
}
