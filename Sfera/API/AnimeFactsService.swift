//
//  AnimeFactsService.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import Foundation
import Alamofire

class AnimeFactsService {
    
    func getFactsAbout(animeName: String, completion: @escaping (SearchFactsEntity) -> Void) {
        if animeName != "", animeName.count > 5 {
            AF.request("https://anime-facts-rest-api.herokuapp.com/api/v1/\(animeName)").validate().responseData(completionHandler: { responseData in
                switch responseData.result {
                case .success(let value):
                    do {
                        let animeFacts = try JSONDecoder().decode(SearchFactsEntity.self, from: value)
                        completion(animeFacts)
                    } catch {
                        print("Error decoding jsonData: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}
