//
//  JokesRepository.swift
//  HSBCDemo
//
//  Created by Ghous Ansari on 31/01/24.
//

import Foundation

protocol JokesRepositoryProtocol {
    func fetchItems(completion: @escaping (Result<JokesResponseArray, Error>) -> Void)
}

class JokesRepository: JokesRepositoryProtocol {
    
    private var _httpUtility: HttpUtility = HttpUtility()
    
    func fetchItems(completion: @escaping (Result<JokesResponseArray, Error>) -> Void) {
        
        // Implement network logic to fetch items from the API
        _httpUtility.postApiData(requestUrl: URL(string: APIEndpoints.jokes)!, method: .GET, resultType: JokesResponseArray.self, completionHandler: { result, apiError in
            if let err = apiError {
                completion(.failure(err))
            } else {
                completion(.success(result ?? []))
            }
        })
    }
}
