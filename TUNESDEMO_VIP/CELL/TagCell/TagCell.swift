//
//  TagCell.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var tagNameLabel: UILabel?
    var tagItem: String?
    
    func loadData(searchItem: String) {
        tagItem = searchItem
        tagNameLabel?.text = tagItem
    }

}
