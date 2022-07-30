//
//  CustomCell.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class CustomCell: UICollectionViewCell{
    
    static let identifier = "CustomCell"
    
    private lazy var parentCell: UIView = {
        let cell = UIView()
        return cell
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 14
        imageV.image = UIImage(systemName: "person")
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanches"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var characterType: UILabel = {
        let label = UILabel()
        label.text = "Human, alive"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
}


extension CustomCell {
    
    func setupConstraints(){
        contentView.backgroundColor = .white
        let elements = [parentCell]
        for element in elements {
            contentView.addSubview(element)
        }
        
        let childs = [characterImage, characterName,characterType]
        
        for child in childs {
            parentCell.addSubview(child)
        }
        
        parentCell.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        characterImage.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(-35)
        }
        
        characterName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(characterImage.snp.bottom).offset(5)
        }
        
        characterType.snp.makeConstraints { make in
            make.top.equalTo(characterName.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    func fetchData(image: String, name: String, type: String){
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(with: URL(string: image), placeholder: nil, options: nil, completionHandler: nil)
        characterName.text = name
        characterType.text = type
    }
    
}
