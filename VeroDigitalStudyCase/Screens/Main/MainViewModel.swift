//
//  MainViewModel.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

protocol MainViewModelInterface:AnyObject {
    var view:MainViewInterface?{get set}
    func viewDidLoad()
    func getData()
    func numberOfRowsInSection()->Int
    func cellForRowAt(indexPath:IndexPath) -> TaskResponse
}


class MainViewModel {
    weak var view:MainViewInterface?
    var tasks:[TaskResponse]?
    private let apiManager : APIManager?
    
    init(view:MainViewInterface,apiManager:APIManager=APIManager.shared) {
        self.view = view
        self.apiManager = apiManager
    }
}


extension MainViewModel:MainViewModelInterface {

    
    
    func viewDidLoad() {
        view?.setupUI()
        view?.configureTableView()
        view?.getData()
    }
    
    func getData() {
        
        apiManager?.getData(completion: { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                UserDefaults.standard.saveModeltoCache(tasks)
                self.view?.reloadData()
            case .failure(let error):
                print(print(error.localizedDescription))
            }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        tasks?.count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TaskResponse {
        guard let tasks = tasks else {return .init(task: "", title: "", description: "", colorCode: "")}
        return tasks[indexPath.row]
    }
}
