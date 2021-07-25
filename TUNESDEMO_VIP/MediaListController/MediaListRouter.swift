//
//  MediaListRouter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol MediaListRoutingLogic {
    func furtherRoot()
}

final class MediaListRouter {
    var navigationController: UINavigationController
    init(navigator: UINavigationController) {
        navigationController = navigator
    }
}

extension MediaListRouter: MediaListRoutingLogic {
    func furtherRoot() {
        print("There is not further navigation")
    }
}
