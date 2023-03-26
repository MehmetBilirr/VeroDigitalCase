//
//  MainViewController.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import UIKit

protocol MainViewInterface:AnyObject {
    func configureTableView()
    func setupUI()
    func getData()
    func reloadData()
    func configureRefreshControl()
    func configureSearchBar()
    var isSearching: Bool {get}
}

class MainViewController: UIViewController {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private lazy var viewModel = MainViewModel(view: self)
    private let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


    
}

extension MainViewController: MainViewInterface {
    
    var isSearching: Bool {
        searchController.isActive
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.refreshControl = refreshControl
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func getData() {
        viewModel.getData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func configureRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        viewModel.getData()
        refreshControl.endRefreshing()
    }
    
    func configureSearchBar() {
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false

    }
    
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.setup(task: viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    
}

extension MainViewController:UISearchResultsUpdating,UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        let lowerText = text.lowercased()
        viewModel.filteredTasks(text: lowerText)
        
        
        
    }

    
}
