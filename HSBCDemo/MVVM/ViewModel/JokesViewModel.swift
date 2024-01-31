//
//  JokesViewModel.swift
//  HSBCDemo
//
//  Created by Ghous Ansari on 31/01/24.
//

import Foundation

class JokesViewModel {
    
    private let repository: JokesRepositoryProtocol
    
    var items: ((JokesResponseArray) -> Void)?
    var onErrorHandling: ((Error) -> Void)?

    init(repository: JokesRepositoryProtocol) {
        self.repository = repository
    }

    func fetchItems() {
        repository.fetchItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.items?(items)
                case .failure(let error):
                    self?.onErrorHandling?(error)
                }
            }
        }
    }
}
