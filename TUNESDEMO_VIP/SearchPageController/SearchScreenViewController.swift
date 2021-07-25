//
//  SearchScreenViewController.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import UIKit

protocol SearchScreenViewControllerInput: AnyObject {
    func showMediaSelection(mediaList: [String])
}

protocol SearchScreenViewControllerOutput: AnyObject {
}


class SearchScreenViewController: UIViewController {
    
    var interactor: SearchScreenInteractor?
    var rounter: SearchScreenRouter?
    var presnter: SearchScreenPresenter?
    
    var mediaTypeList: [String] = []
    
    @IBOutlet weak var textFieldSearch: UITextField?
    @IBOutlet weak var collectionViewMediaList: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContrller()
        setupCollectionView()
    }
    
    func setupContrller() {
        self.interactor = SearchScreenInteractor()
        self.presnter = SearchScreenPresenter()
        self.rounter = SearchScreenRouter(navigator: self.navigationController ?? UINavigationController())
        presnter?.viewController = self
    }
    
    func setupCollectionView() {
        collectionViewMediaList?.registerNib(Constant.tagCellIdentifier)
        collectionViewMediaList?.dataSource = self
        collectionViewMediaList?.delegate = self
    }
    
    @IBAction func btnMediaListClicked(_ sender: Any) {
        rounter?.navigateToMediaList(presenter: presnter ?? SearchScreenPresenter())
    }
    @IBAction func btnSubmitClicked(_ sender: Any) {
        rounter?.navigateToListingScreen(presnter?.selectedList ?? [], textFieldSearch?.text ?? "")
    }
}

extension SearchScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaTypeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.tagCellIdentifier, for: indexPath) as? TagCell
        cell?.loadData(searchItem: mediaTypeList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension SearchScreenViewController: SearchScreenViewControllerInput {
    func showMediaSelection(mediaList: [String]) {
        mediaTypeList = mediaList
        collectionViewMediaList?.reloadData()
    }
}

extension SearchScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presnter?.searchText = textField.text ?? ""
            self.view.endEditing(true)
            return false
    }
}
