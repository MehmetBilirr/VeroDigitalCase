//
//  MockLoginViewController.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 26.03.2023.
//

import Foundation
@testable import VeroDigitalStudyCase

class MockLoginViewController:LoginViewInterface {

    var invokedStyleUI = false
    var invokedStyleUICount = 0

    func styleUI() {
        invokedStyleUI = true
        invokedStyleUICount += 1
    }

    var invokedLayoutUI = false
    var invokedLayoutUICount = 0

    func layoutUI() {
        invokedLayoutUI = true
        invokedLayoutUICount += 1
    }

    var invokedPushToMainVC = false
    var invokedPushToMainVCCount = 0

    func pushToMainVC() {
        invokedPushToMainVC = true
        invokedPushToMainVCCount += 1
    }

    var invokedAddOberserverKeyboard = false
    var invokedAddOberserverKeyboardCount = 0

    func addOberserverKeyboard() {
        invokedAddOberserverKeyboard = true
        invokedAddOberserverKeyboardCount += 1
    }

    var invokedDidTapLogInButton = false
    var invokedDidTapLogInButtonCount = 0

    func didTapLogInButton() {
        invokedDidTapLogInButton = true
        invokedDidTapLogInButtonCount += 1
    }
}
