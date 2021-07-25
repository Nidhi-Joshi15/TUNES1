//
//  ListingScreenInteractor.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

typealias ListingScreenInteractorInput = ListingScreenViewControllerOutput

protocol ListingScreenInteractorOutput: AnyObject {
    func showMediaDetail(_ mediaList: MediaItems?)
    func updateData(_ mediaList: [Section]?)
}

 class ListingScreenInteractor {
    var presenter: ListingScreenPresenterInput?
    var serviceManager = ServiceWorker()
    var urlList = [String]()
    var searchText = ""
    
    @objc func updateStaus() {
    }
}

extension ListingScreenInteractor: ListingScreenInteractorInput {
    
    func generateURL() -> [String] {
        var urls = [String]()
        for entity in urlList {
            var url = Constant.url
            url += "term=" + (searchText)
            url += "&entity=" + entity
            guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return [] }
            urls.append(urlString)
        }
        return urls
    }
    
    func submitRequest() {
        let list = generateURL()
        for url in list {
            serviceManager.fetchMedia(url: url) { (response: Result<ResultData, Error>) in
                switch response {
                case .failure(let error):
                    print("Error \(error)")
                case .success(let list):
                    print("List \(String(describing: list.resultCount)) for \(list.results?.first?.kind) or \(list.results?.first?.collectionType)")
                            self.presenter?.updateData(list.convertMediaToSections())
                }
            }
        }
    }
}
