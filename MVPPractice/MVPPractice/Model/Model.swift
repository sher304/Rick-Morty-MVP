//
//  Model.swift
//  MVPPractice
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation


struct Beer: Codable{
    
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let image_url: String
    
}
