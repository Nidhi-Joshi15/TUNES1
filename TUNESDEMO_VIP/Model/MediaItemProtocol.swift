//
//  MediaItemProtocol.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
protocol MediaItemsProtocol {
    init(sectionList: [Section])
    var sections: [Section] {get set}
}

struct Section {
    var sectionName: String
    var media: [Media]
}

class MediaItems: MediaItemsProtocol {
    var sections: [Section]
    required init(sectionList: [Section]) {
        sections = sectionList
    }

}
