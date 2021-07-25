//
//  ListingScreenPresenter.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation

typealias ListingScreenPresenterInput = ListingScreenInteractorOutput
typealias ListingScreenPresenterOutput = ListingScreenViewControllerInput

enum DisplayView {
    case grid
    case list
}

class ListingScreenPresenter {
    weak var viewController: ListingScreenPresenterOutput?
    var mediaItems: MediaItems?
    var displayMode: DisplayView = .grid
    
    func getSection(_ section: Int) -> Section? {
        return section < (mediaItems?.sections.count ?? 0) ? mediaItems?.sections[section] : nil
    }
    func getItemInSection(_ section: Int) -> [Media]? {
        return section < (mediaItems?.sections.count ?? 0) ? mediaItems?.sections[section].media : []
    }
    
    func getItemAtIndexInSection(_ section: Int, _ index: Int) -> Media? {
        let mediaItemList = getItemInSection(section)
        return index < (mediaItemList?.count ?? 0) ? mediaItemList?[index] : nil
    }
    
    func getSectionCount() -> Int? {
        return mediaItems?.sections.count
    }
    
    func getItemCountInSection(_ section: Int) -> Int? {
        return getItemInSection(section)?.count
    }
}

extension ListingScreenPresenter: ListingScreenPresenterInput {

    func showMediaDetail(_ mediaList: MediaItems?) {
        mediaItems = mediaList
        viewController?.showMediaList()
    }
    func updateData(_ mediaList: [Section]?) {
        if let items = mediaItems {
            items.sections.append(contentsOf: mediaList ?? [])
            mediaItems = items
        } else {
            mediaItems = MediaItems(sectionList: mediaList ?? [])
        }
        DispatchQueue.main.async {
            self.viewController?.showMediaList()
        }
        
    }
}
