//
//  HttpUtility.swift
//  MVVM
//
//  Created by Ghous Ansari on 12/06/23.
//

import Foundation

enum HTTPMethod: String, CaseIterable {
    case POST = "POST"
    case GET = "GET"
}


struct HttpUtility {
    
    func postApiData<T:Decodable>(requestUrl: URL, method: HTTPMethod, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ apiError: APIError?)-> Void) {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(APIHeaders.appKey, forHTTPHeaderField: APIHeaders.X_Api_Key)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if (data != nil)
            {
                if let httpResponse = httpUrlResponse as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 0..<202:
                        do {
                            
                            let response = try JSONDecoder().decode(T.self, from: data!)
                            _ = completionHandler(response, nil)
                        }
                        catch let decodingError {
                            debugPrint(decodingError)
                            _ = completionHandler(nil, .decodingError)
                        }
                    case 203..<501:
                        do {
                            
                            let response = try JSONDecoder().decode(APIResponseFailure.self, from: data!)
                            _ = completionHandler(nil, .errorMsg(response.message))
                        }
                        catch let decodingError {
                            debugPrint(decodingError)
                            _ = completionHandler(nil, .decodingError)
                        }
                    default:
                        break
                    }
                }
                
            }
        }.resume()
    }
}
