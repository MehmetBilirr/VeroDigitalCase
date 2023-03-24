//
//  ViewController.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 24.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AuthManager.shared.login(parameters: Constants.parameters) { result in
            switch result {
            case .success(let success):
                print(success)
                AuthManager.shared.saveToken(result: success)
            case .failure(let failure):
                print(failure)
            }
        }
        
        
    }


}

