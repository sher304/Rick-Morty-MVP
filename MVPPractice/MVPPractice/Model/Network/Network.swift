//
//  Network.swift
//  MVPPractice
//
//  Created by Шермат Эшеров on 27/7/22.
//

import Foundation

protocol NetworkDelegate{
    
    func networkParse(compretion: @escaping ([Beer]) -> ())
    
}

class Network: NetworkDelegate{
    
    let session = URLSession.shared
    
    func networkParse(compretion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=2&per_page=1") else { return }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                guard let request = try? JSONDecoder().decode([Beer].self, from: data) else { return }
                compretion(request)
            }
        }.resume()
    }
}
