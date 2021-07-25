//
//  ServiceManager.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import Network

enum Result<Success, Failure> where Failure: Error {

    case success(Success)

    case failure(Failure)
}

enum RequestError: Error {
    case internetNotConnected
    case requestFailed
}

extension RequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .internetNotConnected:
            return NSLocalizedString(
                "Internet not Connected",
                comment: ""
            )
        case .requestFailed:
            return NSLocalizedString(
                "Request Failed",
                comment: ""
            )
        }
    }
}

class ServiceManager {
    func fetchData(request: URLRequest, onResponse: @escaping (_ result: Result<Data, Error>) -> Void) {
        dataTask?.cancel()
        if  !Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                print("Error")
                return onResponse(.failure(RequestError.internetNotConnected))
            }
        }
        dataTask = urlSession.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error")
                return onResponse(.failure(RequestError.requestFailed))
            }
            print("Success")
            return onResponse(.success(data))
            
        }
        dataTask?.resume()
    }
    
    // MARK: - Private
    
    private var dataTask: URLSessionDataTask?
    private let apiBaseUrl = Constant.url
    private var urlSession: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        return URLSession(configuration: configuration)
    }
    private var apiUrl: URL? {
        return URL(string: apiBaseUrl)
    }
    
    var apiRequest: URLRequest? {
        guard let apiURL = apiUrl  else {
            return nil
        }
        var request = URLRequest(url: apiURL)
        request.cachePolicy = .reloadRevalidatingCacheData
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return request
    }
}
