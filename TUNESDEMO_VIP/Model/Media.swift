//
//  Media.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
class Media: Codable {
    var kind: String?
    var trackId: Int?
    var artistName: String?
    var collectionName: String?
    var collectionType: String?
    var trackName: String?
    var collectionCensoredName: String?
    var artistViewUrl: String?
    var collectionViewUrl: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var collectionPrice: Double?
    var currency: String?
    var trackCensoredName: String?
    var artworkUrl100: String?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case trackId
        case artistName
        case collectionName
        case trackName
        case collectionCensoredName
        case artistViewUrl
        case collectionViewUrl
        case trackViewUrl
        case previewUrl
        case collectionPrice
        case currency
        case trackCensoredName
        case artworkUrl100
        case collectionType
    }

    init(_ artistName: String?, kind: String?) {
        self.trackCensoredName = artistName
        self.kind = kind
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        collectionCensoredName = try values.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
        collectionViewUrl = try values.decodeIfPresent(String.self, forKey: .collectionViewUrl)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        previewUrl = try values.decodeIfPresent(String.self, forKey: .previewUrl)
        collectionPrice = try values.decodeIfPresent(Double.self, forKey: .collectionPrice)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        artworkUrl100 =  try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        collectionType = try values.decodeIfPresent(String.self, forKey: .collectionType)
    }
    
}

/*
 "wrapperType": "track",
       "kind": "music-video",
       "artistId": 909253,
       "collectionId": 1445738051,
       "trackId": 1445738215,
       "artistName": "Jack Johnson",
       "collectionName": "To the Sea",
       "trackName": "You And Your Heart",
       "collectionCensoredName": "To the Sea",
       "trackCensoredName": "You And Your Heart (Closed-Captioned)",
       "artistViewUrl": "https://music.apple.com/us/artist/jack-johnson/909253?uo=4",
       "collectionViewUrl": "https://music.apple.com/us/music-video/you-and-your-heart-closed-captioned/1445738215?uo=4",
       "trackViewUrl": "https://music.apple.com/us/music-video/you-and-your-heart-closed-captioned/1445738215?uo=4",
       "previewUrl": "https://video-ssl.itunes.apple.com/itunes-assets/Video115/v4/f0/92/0c/f0920ce2-8bb7-5e62-b44c-36ce701fe7b1/mzvf_6922739671336234286.640x352.h264lc.U.p.m4v",
       "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Video/v4/ae/be/c8/aebec8f3-2baa-7708-1cb9-af064c5423a4/source/30x30bb.jpg",
       "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Video/v4/ae/be/c8/aebec8f3-2baa-7708-1cb9-af064c5423a4/source/60x60bb.jpg",
       "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Video/v4/ae/be/c8/aebec8f3-2baa-7708-1cb9-af064c5423a4/source/100x100bb.jpg",
       "collectionPrice": 11.99,
       "trackPrice": -1.00,
       "releaseDate": "2010-06-01T07:00:00Z",
       "collectionExplicitness": "notExplicit",
       "trackExplicitness": "notExplicit",
       "discCount": 1,
       "discNumber": 1,
       "trackCount": 15,
       "trackNumber": 14,
       "trackTimeMillis": 197288,
       "country": "USA",
       "currency": "USD",
       "primaryGenreName": "Rock"
 */
