//
//  SearchScreenInteractor.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

typealias SearchScreenInteractorInput = SearchScreenViewControllerOutput

protocol SearchScreenInteractorOutput: AnyObject {
    func showMediaList(mediaTypeList: [String])
}

final class SearchScreenInteractor {
    var presenter: SearchScreenPresenterInput?
    let serviceManager = ServiceManager()

}

extension SearchScreenInteractor: SearchScreenInteractorInput {

}
