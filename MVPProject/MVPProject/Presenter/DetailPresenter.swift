//
//  DetailPresenter.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import Foundation

protocol DetailDelegate{
    func viewDidLoad()
}

class DetailPresenter: DetailDelegate{
    
    private weak var detailVC: DetailVCDelegate?
    private lazy var network: Network = {
        return Network()
    }()
    
    var character = Results(name: "", status: "", species: "", type: "", gender: "", image: "", origin: Origin(name: ""))
    
    func viewDidLoad() {
        network.parseById(id: indx ?? "") { [self] datas in
            character = datas
            detailVC?.reloadData()
        }
    }
    
    var indx: String?
    func setId(id: String){
        indx = id
    }
    
    init(detailVC: DetailVCDelegate){
        self.detailVC = detailVC
    }
    
}
