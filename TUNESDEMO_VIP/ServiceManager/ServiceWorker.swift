//
//  ServiceWorker.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 05/05/2021.
//

import Foundation

class ServiceWorker {
  var manager = ServiceManager()
    let queue = OperationQueue()

  func fetchMedia<T: Codable>(url: String, onResponse: @escaping (_ result: Result<T, Error>) -> Void) {
    
    guard var request = manager.apiRequest  else {
        print("Error0000")
        return onResponse(.failure(RequestError.requestFailed))
    }
    
    request.url = URL(string: url)
    
    
    let operation = BlockOperation(block: {
        self.manager.fetchData(request: request) { (result) in
            switch result {
            case .failure(let error):
                print("Error in operation")
                onResponse(.failure(error))
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    print("success  in operation")
                    onResponse(.success(response))
                } catch let err {
                    print("Error  in operation")
                    onResponse(.failure(err))
                }
            }
        }
    })
    operation.completionBlock = {
        print("Operation  completed, cancelled:\(operation.isCancelled)")
    }
    
    queue.addOperation(operation)
    
    
  }
}
