//
//  DetailScreenViewController.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import  UIKit
import AVKit

protocol DetailScreenViewControllerInput: AnyObject {
}

protocol DetailScreenViewControllerOutput: AnyObject {
}

class DetailScreenViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var imageViewMediaImage: UIImageView?
    
    @IBOutlet weak var lblMediaTitle: UILabel?
    
    @IBOutlet weak var lblMediaDetail: UILabel?
    
    @IBOutlet weak var lblMediaSubdetail: UILabel?
    
    var player: AVPlayer?
    var interactor: DetailScreenInteractor?
    var presenter: DetailScreenPresenter?
    
    override func viewDidLoad() {
        setupData()
        super.viewDidLoad()
    }
    @IBAction func playVideoClicked(_ sender: Any) {
        setupVideo()
    }
    
    func setupData() {
        lblMediaTitle?.text = "Type : " + ((presenter?.mediaItem?.kind ?? presenter?.mediaItem?.collectionType) ?? "")
        lblMediaTitle?.sizeToFit()
        lblMediaDetail?.text = "Collection Name : " + (presenter?.mediaItem?.collectionCensoredName ?? "")
        lblMediaDetail?.sizeToFit()
        lblMediaSubdetail?.text = "Artist : " + (presenter?.mediaItem?.artistName ?? "")
        lblMediaSubdetail?.sizeToFit()
        imageViewMediaImage?.sd_setImage(with: URL(string: (presenter?.mediaItem?.artworkUrl100)  ?? ""), placeholderImage: UIImage(named: "placeholderImage"))
    }

    func setupVideo() {
        guard let url = URL(string: presenter?.mediaItem?.previewUrl ?? "") else {
            print("Umm, looks like an invalid URL!")
            return
        }

        player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.delegate = self
        controller.player = player

        present(controller, animated: true) {
            self.player?.play()
        }
    }
    
}
