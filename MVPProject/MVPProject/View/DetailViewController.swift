//
//  DetailViewController.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import UIKit
import SnapKit

protocol DetailVCDelegate: AnyObject{
    func reloadData()
    func fetchId(id: String)
}

class DetailViewController: UIViewController {
    
    private lazy var detailPresenter: DetailPresenter = {
        return DetailPresenter(detailVC: self)
    }()

    private lazy var chatacterLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor(red: 8/255, green: 175/255, blue: 199/255, alpha: 2)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPresenter.viewDidLoad()
        setupConstraint()
    }
}


extension DetailViewController{
    func setupConstraint(){
        view.backgroundColor = .white
        
        let elements = [chatacterLabel]
        for element in elements {
            view.addSubview(element)
        }
        chatacterLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension DetailViewController: DetailVCDelegate{

    func reloadData(){
        DispatchQueue.main.async { [self] in
            let items = detailPresenter.character
            chatacterLabel.text = items.name
        }
    }

    func fetchId(id: String){
        detailPresenter.setId(id: id)
    }
    
}

