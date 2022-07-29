//
//  ViewController.swift
//  MVPPractice
//
//  Created by Шермат Эшеров on 27/7/22.
//

import UIKit
import SnapKit

protocol ViewControllerDelegate: AnyObject{
    func shareResult()
}

class ViewController: UIViewController {

    private lazy var presenter: Presenter = {
        return Presenter(view: self)
    }()
    
    private lazy var tableView: UITableView = {
        let talbe = UITableView()
        talbe.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        talbe.delegate = self
        talbe.dataSource = self
        return talbe
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.shareData()
        setupConstraints()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.datasBeer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return CustomCell(frame: .zero)}
        let items = presenter.datasBeer[indexPath.row]
        cell.fetchData(title: items.name)
        return cell
    }
}

extension ViewController{
    
    func setupConstraints(){
        view.backgroundColor = .white
        let elements = [tableView]
        for element in elements {
            view.addSubview(element)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}

extension ViewController: ViewControllerDelegate{
    func shareResult() {
        DispatchQueue.main.async { [self] in
            presenter.shareData()
            self.tableView.reloadData()
        }
    }
}
