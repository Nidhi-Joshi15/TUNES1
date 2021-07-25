//
//  MediaListPresenter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation

typealias MediaListPresenterInput = MediaListInteractorOutput
typealias MediaListPresenterOutput = MediaListViewControllerInput

final class MediaListPresenter {
    weak var viewController: MediaListPresenterOutput?
    var mediaTypeList = [String]()
    var selectedTypelist = [String]()
    
    init(_ selected: [String]) {
        selectedTypelist = selected
    }
    
    func getItemsList() -> [String]? {
        return mediaTypeList
    }
    
    func getItemsCount() -> Int? {
        return mediaTypeList.count
    }
    
    func getSelectedList() -> [String] {
        return selectedTypelist
    }
    
    func getItemAtList(_ index: Int) -> String? {
        return index < mediaTypeList.count ? mediaTypeList[index] : nil
    }
    func addItemToList(_ mediaType: String) {
        if !selectedTypelist.contains(mediaType) {
            selectedTypelist.append(mediaType)
        } else {
            selectedTypelist = selectedTypelist.filter { $0 != mediaType }
        }
    }
    
}
extension MediaListPresenter: MediaListPresenterInput {
    func showMediaList(_ mediaList: [String]) {
        mediaTypeList = mediaList
        viewController?.showMediaList(list: mediaList)
    }
    
}
