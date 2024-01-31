//
//  JokesResponse.swift
//  HSBCDemo
//
//  Created by Ghous Ansari on 31/01/24.
//

import Foundation

// MARK: - API Jokes Response
struct JokesResponse: Codable {
    let joke: String
}

typealias JokesResponseArray = [JokesResponse]
