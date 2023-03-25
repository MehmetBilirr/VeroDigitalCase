//
//  ViewController.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import UIKit
import SnapKit

protocol LoginViewInterface:AnyObject {
    
    func styleUI()
    func layoutUI()
    func pushToMainVC()
    
}

class LoginViewController: UIViewController {
    private lazy var viewModel = LoginViewModel(view: self)
    private let  userNameLbl = UILabel()
    private let userNameTxtFld = UITextField()
    private let  passwordLbl = UILabel()
    private let passwordTxtFld = UITextField()
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
       
    }
 
    
    @objc func didTapLogInButton(){
        guard let userName = userNameTxtFld.text , let password = passwordTxtFld.text else { return}
        viewModel.login(userName: userName, password: password)
    }


}

extension LoginViewController:LoginViewInterface {
    func styleUI() {
        
        view.backgroundColor = .systemBackground
        
        userNameLbl.configureStyle(size: 25, weight: .bold, color: .black)
        userNameLbl.text = "UserName"
        
        userNameTxtFld.frame = CGRect(x: 0, y: 0, width: self.view.width - 60, height: 30)
        userNameTxtFld.addBottomLayer(.lightGray, 0.1)
        userNameTxtFld.placeholder = "UserName"
        userNameTxtFld.delegate = self
        
        passwordLbl.configureStyle(size: 25, weight: .bold, color: .black)
        passwordLbl.text = "Password"
        
        passwordTxtFld.frame = CGRect(x: 0, y: 0, width: self.view.width - 60, height: 30)
        passwordTxtFld.addBottomLayer(.lightGray, 0.1)
        passwordTxtFld.placeholder = "Password"
        passwordTxtFld.delegate = self
        
        loginButton.configureStyleTitleButton(title: "Log In", titleColor: .black, backgroundClr: .purple, cornerRds: 25)
        loginButton.alpha = 0.5
        loginButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
    }
    
    func layoutUI() {
        
        view.addSubview(userNameLbl)
        
        userNameLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(200)
        }
        
        view.addSubview(userNameTxtFld)
        
        userNameTxtFld.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(userNameLbl.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(view.width - 60)
        }
        
        view.addSubview(passwordLbl)
        
        passwordLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(userNameTxtFld.snp.bottom).offset(50)
        }
        
        view.addSubview(passwordTxtFld)
        
        passwordTxtFld.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(passwordLbl.snp.bottom).offset(10)
        }
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(passwordTxtFld.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
    }
    
    func pushToMainVC() {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
}

extension LoginViewController:UITextFieldDelegate {
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != ""  {
            loginButton.alpha = 1
        }
      
    }
    
    
}
