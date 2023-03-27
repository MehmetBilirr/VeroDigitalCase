//
//  QRViewModel.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 27.03.2023.
//

import Foundation

protocol QRViewModelInterface {
    var view:QRViewInterface?{get set}
    func viewDidLoad()
}

final class QRViewModel:QRViewModelInterface {
    weak var view: QRViewInterface?
    
    init(view: QRViewInterface) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.configurePreviewLayer()
        view?.handleInput()
        view?.handleOutput()
    }
    
   
    
    
}
