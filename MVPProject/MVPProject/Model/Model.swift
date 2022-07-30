//
//  Model.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import Foundation

struct RickAndMorty: Codable{
    let results: [Results]
}

struct Results: Codable{
    let name, status, species, type, gender, image: String
    let origin: Origin
}


struct Origin: Codable {
    let name: String
}
