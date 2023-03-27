//
//  LoginViewTests.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 26.03.2023.
//

import XCTest
@testable import VeroDigitalStudyCase

final class LoginViewTests: XCTestCase {

    private var viewModel : LoginViewModel!
    private var view:MockLoginViewController!
    private var authManager:MockAuthManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        authManager = .init()
        viewModel = .init(view: view,authManager: authManager)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func test_viewDidLoad_invokesRequiredMethods() {
        
        XCTAssertFalse(view.invokedStyleUI)
        XCTAssertFalse(view.invokedLayoutUI)
        XCTAssertFalse(view.invokedAddOberserverKeyboard)

        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedStyleUICount, 1)
        XCTAssertEqual(view.invokedLayoutUICount, 1)
        XCTAssertEqual(view.invokedAddOberserverKeyboardCount, 1)
        
    }
    
    func test_didTapLoginButton_getToken_invokesRequiredMethods(){
        let authResponse = AuthResponse.init(oauth: .init(accessToken: "", expiresIn: 1, tokenType: "", refreshToken: ""))
        
        XCTAssertFalse(authManager.invokedLogin)
        XCTAssertNil(authManager.invokedLoginParameters)
        XCTAssertFalse(view.invokedPushToMainVC)
        XCTAssertFalse(authManager.invokedSaveToken)
        
        authManager.stubbedLoginCompletionResult?.0 = .success(authResponse)
        viewModel.login(userName: "365", password: "1")
        
        
        XCTAssertEqual(authManager.invokedLoginCount, 1)
        XCTAssertNotNil(authManager.invokedLoginParameters)
        XCTAssertEqual(view.invokedPushToMainVCCount, 1)
        
 
        
    }
    
    func test_didLogIn_whenDidSignIn_invokesRequiredMethods(){
        
        XCTAssertFalse(authManager.invokedIsSignedInGetter)

        authManager.stubbedIsSignedIn = true
        
        XCTAssertEqual(authManager.isSignedIn,true)
        XCTAssertEqual(authManager.invokedIsSignedInGetterCount, 1)
    }
    
    func test_didTapLoginButton_getTokenFailure_invokesRequiredMethods(){
        
        XCTAssertFalse(authManager.invokedLogin)
        XCTAssertNil(authManager.invokedLoginParameters)
        XCTAssertFalse(view.invokedPushToMainVC)
        
        viewModel.login(userName: "365", password: "1")
        authManager.stubbedLoginCompletionResult?.0 = .failure(AppError.unknownError)
        
        XCTAssertEqual(view.invokedPushToMainVCCount, 0)
        
    }
   
    
}
