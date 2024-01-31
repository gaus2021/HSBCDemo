//
//  MockJokesRepository.swift
//  HSBCDemo
//
//  Created by Ghous Ansari on 31/01/24.
//

import Foundation

class MockJokesRepository: JokesRepositoryProtocol {
    var shouldReturnError = false

    func fetchItems(completion: @escaping (Result<JokesResponseArray, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        } else {
            completion(.success([JokesResponse(joke: "Sample Joke")]))
        }
    }
}
