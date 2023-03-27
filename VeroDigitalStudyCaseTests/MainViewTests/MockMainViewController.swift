//
//  MockMainViewController.swift
//  VeroDigitalStudyCaseTests
//
//  Created by Mehmet Bilir on 27.03.2023.
//

import Foundation
@testable import VeroDigitalStudyCase

class MockMainViewController:MainViewInterface {

    var invokedIsSearchingGetter = false
    var invokedIsSearchingGetterCount = 0
    var stubbedIsSearching: Bool! = false

    var isSearching: Bool {
        invokedIsSearchingGetter = true
        invokedIsSearchingGetterCount += 1
        return stubbedIsSearching
    }

    var invokedConfigureTableView = false
    var invokedConfigureTableViewCount = 0

    func configureTableView() {
        invokedConfigureTableView = true
        invokedConfigureTableViewCount += 1
    }

    var invokedConfigureNavigationBar = false
    var invokedConfigureNavigationBarCount = 0

    func configureNavigationBar() {
        invokedConfigureNavigationBar = true
        invokedConfigureNavigationBarCount += 1
    }

    var invokedSetupUI = false
    var invokedSetupUICount = 0

    func setupUI() {
        invokedSetupUI = true
        invokedSetupUICount += 1
    }

    var invokedGetData = false
    var invokedGetDataCount = 0

    func getData() {
        invokedGetData = true
        invokedGetDataCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedConfigureRefreshControl = false
    var invokedConfigureRefreshControlCount = 0

    func configureRefreshControl() {
        invokedConfigureRefreshControl = true
        invokedConfigureRefreshControlCount += 1
    }

    var invokedConfigureSearchBar = false
    var invokedConfigureSearchBarCount = 0

    func configureSearchBar() {
        invokedConfigureSearchBar = true
        invokedConfigureSearchBarCount += 1
    }

    var invokedAddObserverQR = false
    var invokedAddObserverQRCount = 0

    func addObserverQR() {
        invokedAddObserverQR = true
        invokedAddObserverQRCount += 1
    }
}
