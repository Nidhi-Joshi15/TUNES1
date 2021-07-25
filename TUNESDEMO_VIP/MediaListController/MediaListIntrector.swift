//
//  MediaListInteractor.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation

typealias MediaListInteractorInput = MediaListViewControllerOutput

protocol MediaListInteractorOutput: AnyObject {
    func showMediaList(_ mediaList: [String])
}

final class MediaListInteractor {
    var presenter: MediaListPresenterInput?
    var data = MediaListData()
}

extension MediaListInteractor: MediaListInteractorInput {
    func getMediaList() {
        presenter?.showMediaList(data.getMediaTypeList())
    }
}
