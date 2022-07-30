//
//  ViewController.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import UIKit
import SnapKit

protocol VCDelegate: AnyObject{
    func reloadData()
}

class ViewController: UIViewController {

    private lazy var cartoonPoster: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "poster")
        imageV.backgroundColor = .orange
        imageV.layer.cornerRadius = 14
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var posterLabel: UILabel = {
        let label = UILabel()
        label.text = "Comming Soon"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    private lazy var chatacterLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = UIColor(red: 8/255, green: 175/255, blue: 199/255, alpha: 2)
        return label
    }()
    
    private lazy var mainCharacterLabel: UILabel = {
        let label = UILabel()
        label.text = "Main Characters"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGreen
        label.textColor = UIColor(red: 112/255, green: 196/255, blue: 43/255, alpha: 255)
        return label
    }()
            
    private lazy var presenter: Presenter = {
        return Presenter(viewDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupConstraints()
        
    }
}

extension ViewController: VCDelegate{
    func reloadData() {
        collectionView.reloadData()
    }
}

extension ViewController{
    
    func setupConstraints(){
        view.backgroundColor = .white
        let elements = [collectionView, cartoonPoster, chatacterLabel, mainCharacterLabel]
        for element in elements {
            view.addSubview(element)
        }
        
        let childs = [posterLabel]
        
        for child in childs {
            cartoonPoster.addSubview(child)
        }

        cartoonPoster.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(213)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-5)
            make.leading.equalTo(10)
        }
        
        chatacterLabel.snp.makeConstraints { make in
            make.top.equalTo(cartoonPoster.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
        
        mainCharacterLabel.snp.makeConstraints { make in
            make.top.equalTo(chatacterLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(mainCharacterLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.characters.first?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return CustomCell(frame: .zero)}
        guard let items = presenter.characters.first?.results[indexPath.row] else { return CustomCell(frame: .zero)}
        cell.fetchData(image: items.image, name: items.name, type: "\(items.gender) \(items.status)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var indexSelected = indexPath.row
        indexSelected += 1
        let vc = DetailViewController()
        vc.fetchId(id: indexSelected.description)
        present(vc, animated: true, completion: nil)
    }
    
}
