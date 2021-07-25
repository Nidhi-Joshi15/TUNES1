//
//  SearchScreenRouter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol SearchScreenRoutingLogic {
    func navigateToMediaList(presenter: SearchScreenPresenter)
    func navigateToListingScreen(_ urlList: [String], _ searchText: String)
}

final class SearchScreenRouter {
    var navigationController: UINavigationController
    init(navigator: UINavigationController) {
        navigationController = navigator
    }
}

extension SearchScreenRouter: SearchScreenRoutingLogic {
    
    func navigateToMediaList(presenter: SearchScreenPresenter) {
        let viewController = MediaListViewController.create(of: .main)
        let router = MediaListRouter(navigator: self.navigationController)
        let interactor = MediaListInteractor()
        let presneter = MediaListPresenter(presenter.selectedList)
        
        interactor.presenter = presneter
        viewController.rounter = router
        viewController.interactor = interactor
        viewController.presnter = presneter
        viewController.delegate = presenter
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToListingScreen(_ urlList: [String], _ searchText: String) {
        let viewController = ListingScreenViewcontroller.create(of: .main)
        let router = ListingScreenRouter(navigator: navigationController)
        let interactor = ListingScreenInteractor()
        let presneter = ListingScreenPresenter()
        
        interactor.urlList = urlList
        interactor.searchText = searchText
        viewController.interactor = interactor
        viewController.presnter = presneter
        viewController.rounter = router
        
        interactor.presenter = presneter
        presneter.viewController = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
}
