//
//  Network.swift
//  MVPProject
//
//  Created by Шермат Эшеров on 29/7/22.
//

import Foundation

protocol NetworkDelegate{
    func parseData(completion: @escaping (RickAndMorty) -> Void)
    func parseById(id: String,completion: @escaping (Results) -> Void)
}

class Network: NetworkDelegate{
   
    let session = URLSession.shared

    func parseData(completion: @escaping (RickAndMorty) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { return }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let request = try? JSONDecoder().decode(RickAndMorty.self, from: data) else { return }
                completion(request)
            }
        }.resume()
    }
    
    func parseById(id: String, completion: @escaping (Results) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        session.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let request = try? JSONDecoder().decode(Results.self, from: data) else { return }
                completion(request)
            }
        }.resume()
    }
}
