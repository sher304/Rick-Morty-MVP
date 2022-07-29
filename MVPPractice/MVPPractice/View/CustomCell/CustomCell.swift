//
//  CustomCell.swift
//  MVPPractice
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation
import UIKit
import SnapKit

class CustomCell: UITableViewCell{
    
    static let identifier = "CustomCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
        
    }
    
}

extension CustomCell{
    func setupConstraint(){
        let elements = [titleLabel]
        for element in elements {
            contentView.addSubview(element)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func fetchData(title: String){
        self.titleLabel = titleLabel
    }
}
