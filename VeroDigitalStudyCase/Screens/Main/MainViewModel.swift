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


final class MainViewModel {
    weak var view:MainViewInterface?
    var tasks : [TaskResponse]  = {
        guard let tasks = UserDefaults.standard.getCacheModels() else {return []}
        return tasks
    }()
    var filteredTasks = [TaskResponse]()
    private let apiManager : APIManagerInterface?
    
    init(view:MainViewInterface,apiManager:APIManagerInterface=APIManager.shared) {
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
        view?.addObserverQR()
    }
    
    func getData() {
        apiManager?.getData(completion: { result in
            switch result {
            case .success(let tasks):
                UserDefaults.standard.saveModeltoCache(tasks)
                self.view?.reloadData()
            case .failure(let error):
                ProgressHUD.showFailed(error.localizedDescription)
            }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        
        if view?.isSearching == true {
            return filteredTasks.count
        }else {
            return tasks.count
        }
        
        
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TaskResponse {
        
        if view?.isSearching == true {
            return filteredTasks[indexPath.row]
        }else {
            return tasks[indexPath.row]
        }

    }
    
    func filteredTasks(text: String) {
        filteredTasks = tasks.filter({ task in
            
     
                let title =  task.title.lowercased().contains(text)
                let task = task.task.lowercased().contains(text)
                let description = task.description.lowercased().contains(text)

                return title || task || description
            
        })
        view?.reloadData()
    }
}
