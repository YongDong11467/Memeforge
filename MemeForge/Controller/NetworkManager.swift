//
//  NetworkManager.swift
//  MemeForge
//
//  Created by APPLE on 9/24/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func getMemes(completion: @escaping(Result<[Meme], Error>) -> Void) {
        
        guard let apiURL = URL(string: "https://api.imgflip.com/get_memes") else {
            return
        }
        
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard let jsonData = data else {
                return completion(.failure(error!))
            }
            
            do {
                let decoder = JSONDecoder()
                let memeResponse = try decoder.decode(Wrapper.self, from: jsonData)
                let memes = memeResponse.data.memes
                completion(.success(memes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
