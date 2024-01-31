//
//  ApiErrors.swift
//  MVVM
//
//  Created by Ghous Ansari on 13/06/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible, Equatable {
    
    case requestFailed
    case authenticationError
    case serverError
    case decodingError
    case encodingError
    case errorMsg(String)
    // Add more cases as needed
    
    var description: String {
        switch self {
        case .requestFailed: return "API Request Failed"
        case .authenticationError: return "API Authentication Failed"
        case .serverError: return "Server Error Occured"
        case .decodingError: return "Decoding Error Occured"
        case .encodingError: return "Encoding Error Occured"
        case .errorMsg(let message): return message
        }
        
    }
}

struct APIResponseFailure: Codable {
    let message: String
}
