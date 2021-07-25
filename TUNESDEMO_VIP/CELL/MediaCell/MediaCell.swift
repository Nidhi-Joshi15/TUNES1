//
//  MediaCell.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import UIKit
import SDWebImage

class MediaCell: UICollectionViewCell {
    @IBOutlet weak var mediaImage: UIImageView?
    @IBOutlet weak var mediaTitle: UILabel?

    var mediaItem: Media?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(media: Media?) {
        mediaItem = media
        mediaTitle?.text = media?.trackCensoredName ?? media?.collectionName
        mediaImage?.sd_setImage(with: URL(string: (media?.artworkUrl100)  ?? ""), placeholderImage: UIImage(named: "placeholderImage"))
    }
    
}
