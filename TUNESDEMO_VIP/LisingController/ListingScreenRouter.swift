//
//  ListingScreenRouter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol ListingScreenRoutingLogic {
    func navigateToDetailScreen(_ media: Media?)
}

final class ListingScreenRouter {
    var navigationController: UINavigationController
    init(navigator: UINavigationController) {
        navigationController = navigator
    }
}

extension ListingScreenRouter: ListingScreenRoutingLogic {
    func navigateToDetailScreen(_ media: Media?) {
        let viewController = DetailScreenViewController.create(of: .main)
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()
        
        presenter.mediaItem = media
        
        viewController.interactor = interactor
        viewController.presenter = presenter

        navigationController.pushViewController(viewController, animated: true)
    }

}
