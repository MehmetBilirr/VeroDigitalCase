//
//  MainViewModel.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation
import ProgressHUD

protocol MainViewModelInterface:AnyObject {
    var view:MainViewInterface?{get set}
    func viewDidLoad()
    func getData()
    func numberOfRowsInSection()->Int
    func cellForRowAt(indexPath:IndexPath) -> TaskResponse
    func filteredTasks(text:String)
}


class MainViewModel {
    weak var view:MainViewInterface?
    var tasks = [TaskResponse]()
    var filteredTasks = [TaskResponse]()
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
        view?.configureRefreshControl()
        view?.configureSearchBar()
        view?.configureNavigationBar()
    }
    
    func getData() {
        
        apiManager?.getData(completion: { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                UserDefaults.standard.saveModeltoCache(tasks)
                self.view?.reloadData()
            case .failure(let error):
                ProgressHUD.showFailed(error.localizedDescription)
            }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        if view?.isSearching ?? false {
            return filteredTasks.count
        }else {
            return UserDefaults.standard.getCacheModels()?.count ?? 0
        }
        
        
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TaskResponse {
        guard let tasks = UserDefaults.standard.getCacheModels() else {return .init(task: "", title: "", description: "", colorCode: "")}
        
        if view?.isSearching ?? false{
            return filteredTasks[indexPath.row]
        }else {
            return tasks[indexPath.row]
        }

    }
    
    func filteredTasks(text: String) {
        guard let tasks = UserDefaults.standard.getCacheModels() else {return}
        filteredTasks = tasks.filter({ task in
            
            if text != "" {
                
                let title =  task.title.lowercased().contains(text)
                let task = task.task.lowercased().contains(text)
                let description = task.description.lowercased().contains(text)
                
                
                return title || task || description ?? false
            }else {
                return false
            }
            
        })
        view?.reloadData()
    }
}
