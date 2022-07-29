//
//  Presenter.swift
//  MVPPractice
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation

protocol PresenterDelegate{
    init(view: ViewControllerDelegate)
    func viewDidLoad()
    func shareData()
}

class Presenter: PresenterDelegate{
   
    private weak var view: ViewControllerDelegate?
    private let network: Network!
    
    var datasBeer: [Beer] = []
    
    required init(view: ViewControllerDelegate){
        self.view = view
        self.network = Network()
    }
    
    func viewDidLoad() {
        network.networkParse { [self] datas in
            datasBeer = datas
            view?.shareResult()
        }
    }
    
    func shareData() {
        view?.shareResult()
    }
    
}
