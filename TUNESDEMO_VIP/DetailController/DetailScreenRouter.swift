//
//  DetailScreenRouter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol DetailScreenRoutingLogic {
    func furtherRoot()
}

final class DetailScreenRouter {
    var navigationController: UINavigationController
    init(navigator: UINavigationController) {
        navigationController = navigator
    }
}

extension DetailScreenRouter: DetailScreenRoutingLogic {
    func furtherRoot() {
        print("There is not further navigation")
    }
}
