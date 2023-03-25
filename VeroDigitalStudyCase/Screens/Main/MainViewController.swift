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
}

class MainViewController: UIViewController {
    private let tableView = UITableView()
    private lazy var viewModel = MainViewModel(view: self)
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
    
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func getData() {
        viewModel.getData()
    }
    
    func reloadData() {
        tableView.reloadData()
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
