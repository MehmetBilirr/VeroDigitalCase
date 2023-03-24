//
//  ViewController.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import UIKit
import SnapKit

protocol LoginViewInterface:AnyObject {
    
    func style()
    func layout()
    
}

class LoginViewController: UIViewController {
    private lazy var viewModel = LoginViewModel(view: self)
    private let userNameLbl = UILabel()
    private lazy var userNameTxtFld = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.width - 60, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        AuthManager.shared.login(parameters: Constants.parameters) { result in
            switch result {
            case .success(let authResponse):
                AuthManager.shared.saveToken(result: authResponse)
            case .failure(let failure):
                print(failure)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
           
            print(UserDefaults.standard.string(forKey: "access_token"))
        })
        
    }


}

extension LoginViewController:LoginViewInterface {
    func style() {
        
        view.backgroundColor = .white
        
        userNameLbl.configureStyle(size: 25, weight: .bold, color: .black)
        userNameLbl.text = "User Name"
        
        userNameTxtFld.addBottomLayer(.gray, 0.1)
        userNameTxtFld.placeholder = "User Name"
        
        userNameLbl.configureStyle(size: 25, weight: .bold, color: .black)
        userNameLbl.text = "User Name"
        
    }
    
    func layout() {
        
        view.addSubview(userNameLbl)
        
        userNameLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(200)
        }
        
        view.addSubview(userNameTxtFld)
        userNameTxtFld.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(userNameLbl.snp.bottom).offset(10)
        }
    }
    
    
}
