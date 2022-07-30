//
//  Presenter.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import Foundation

protocol PresenterDelegate{
    func viewDidLoad()
}

class Presenter: PresenterDelegate{
    private weak var viewDelegate: VCDelegate?
    private lazy var network: Network = {
        return Network()
    }()
    
    var characters: [RickAndMorty] = []
    
    init(viewDelegate: VCDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        network.parseData{ [self] datas in
            characters.append(datas)
            viewDelegate?.reloadData()
        }
    }
}
