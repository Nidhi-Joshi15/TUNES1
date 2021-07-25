//
//  DetailScreenPresenter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
typealias DetailScreenPresenterInput = DetailScreenInteractorOutput
typealias DetailScreenPresenterOutput = DetailScreenViewControllerInput

final class DetailScreenPresenter {
    weak var viewController: DetailScreenPresenterOutput?
    var mediaItem: Media?

}

extension DetailScreenPresenter: DetailScreenPresenterInput {

}
