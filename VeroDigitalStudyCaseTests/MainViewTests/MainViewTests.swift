//
//  MainViewTests.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 27.03.2023.
//

import Foundation

import XCTest
@testable import VeroDigitalStudyCase

final class MainViewTests: XCTestCase {

    private var viewModel : MainViewModel!
    private var view:MockMainViewController!
    private var apiManager:MockApiManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        apiManager = .init()
        viewModel = .init(view: view,apiManager: apiManager)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func test_viewDidLoad_invokesRequiredMethods() {
        
        XCTAssertFalse(view.invokedConfigureNavigationBar)
        XCTAssertFalse(view.invokedConfigureRefreshControl)
        XCTAssertFalse(view.invokedGetData)
        XCTAssertFalse(view.invokedSetupUI)
        XCTAssertFalse(view.invokedAddObserverQR)
        XCTAssertFalse(view.invokedConfigureRefreshControl)
        XCTAssertFalse(view.invokedConfigureSearchBar)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureNavigationBarCount, 1)
        XCTAssertEqual(view.invokedConfigureRefreshControlCount, 1)
        XCTAssertEqual(view.invokedGetDataCount, 1)
        XCTAssertEqual(view.invokedSetupUICount, 1)
        XCTAssertEqual(view.invokedAddObserverQRCount,1)
        XCTAssertEqual(view.invokedConfigureRefreshControlCount,1)
        XCTAssertEqual(view.invokedConfigureSearchBarCount,1)
    }
        
    
    
    func test_fetchData_invokesRequiredMethods() {
        let taskResponse = [TaskResponse.init(task: "", title: "", description: "", colorCode: "")]
        
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(apiManager.invokedGetData)
        
        viewModel.getData()
        apiManager.stubbedGetDataCompletionResult = (.success(taskResponse), ())
        
        XCTAssertEqual(apiManager.invokedGetDataCount,1)
    
    }
    
    func test_notFetchData_invokesRequiredMethods() {
        let taskResponse = [TaskResponse.init(task: "", title: "", description: "", colorCode: "")]
        
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(apiManager.invokedGetData)
        
        viewModel.getData()
        apiManager.stubbedGetDataCompletionResult = (.failure(AppError.unknownError), ())
        
        
        XCTAssertEqual(apiManager.invokedGetDataCount,1)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
    
    }
    
    func test_searchingActive_invokesRequiredMethods(){
        
        XCTAssertFalse(view.invokedIsSearchingGetter)
        
        view.stubbedIsSearching = true
        viewModel.filteredTasks = [.init(task: "", title: "", description: "", colorCode: "")]
        viewModel.cellForRowAt(indexPath: .init(item: 0, section: 0))
        
        XCTAssertEqual(view.invokedIsSearchingGetterCount,1)
     
    }

    func test_searchingNotActive_invokesRequiredMethods(){
        
        XCTAssertFalse(view.invokedIsSearchingGetter)
        
        view.stubbedIsSearching = false
        
        XCTAssertEqual(view.invokedIsSearchingGetterCount,0)
     
    }
    
    
    func test_FilteredTasks_RequiredMethods(){
        
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertEqual(viewModel.filteredTasks.count, 0)
        
        viewModel.filteredTasks(text: "a")
        
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        
        XCTAssertGreaterThan(viewModel.filteredTasks.count, 0)
    }
    
    func test_FilteredTasks_EmptySearch_RequiredMethods(){
        
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertEqual(viewModel.filteredTasks.count, 0)
        
        viewModel.filteredTasks(text: "")
        
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        
        XCTAssertEqual(viewModel.filteredTasks.count, 0)
    }
}
