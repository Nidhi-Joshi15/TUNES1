//
//  DetailScreenInteractor.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

typealias DetailScreenInteractorInput = DetailScreenViewControllerOutput

protocol DetailScreenInteractorOutput: AnyObject {
  
}

final class DetailScreenInteractor {
    var presenter: DetailScreenPresenterInput?
}

extension DetailScreenInteractor: DetailScreenInteractorInput {
    
}
