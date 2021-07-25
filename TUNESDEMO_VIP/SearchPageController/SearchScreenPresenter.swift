//
//  SearchScreenPresenter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation

typealias SearchScreenPresenterInput = SearchScreenInteractorOutput
typealias SearchScreenPresenterOutput = SearchScreenViewControllerInput

final class SearchScreenPresenter {
    weak var viewController: SearchScreenPresenterOutput?
    var selectedList = [String]()
    var searchText: String = ""
}

extension SearchScreenPresenter: SearchScreenPresenterInput {
    func showMediaList(mediaTypeList: [String]) {
        dispatchPrecondition(condition: .onQueue(.main))
        selectedList = mediaTypeList
        viewController?.showMediaSelection(mediaList: mediaTypeList)
    }
    
}
