//
//  ListingScreenViewcontroller.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import Foundation
import  UIKit

protocol ListingScreenViewControllerInput: AnyObject {
    func showMediaList()
}

protocol ListingScreenViewControllerOutput: AnyObject {
    func submitRequest()
}

class ListingScreenViewcontroller: UIViewController {
    
    @IBOutlet weak var listingCollectionView: UICollectionView?

    var interactor: ListingScreenInteractor?
    var rounter: ListingScreenRouter?
    var presnter: ListingScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.submitRequest()
        setupCollectionView()
    }
    
    @IBAction func displayModehasChanged(_ sender: Any) {
        presnter?.displayMode = presnter?.displayMode == DisplayView.grid ? .list : .grid
        listingCollectionView?.setContentOffset(CGPoint.zero, animated: false)
        listingCollectionView?.reloadData()
    }
    
    func setupCollectionView() {
        listingCollectionView?.registerNib(Constant.mediaCellIdentifier)
        listingCollectionView?.registerNib(Constant.mediaSingleCellIdentifier)
        listingCollectionView?.registerNib(Constant.headerView)
        
        listingCollectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.headerView)
        listingCollectionView?.dataSource = self
        listingCollectionView?.delegate = self
    }
}

extension ListingScreenViewcontroller: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presnter?.getSectionCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presnter?.getItemCountInSection(section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rounter?.navigateToDetailScreen(presnter?.getItemAtIndexInSection(indexPath.section, indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch presnter?.displayMode {
        case .grid:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constant.mediaCellIdentifier, for: indexPath) as? MediaCell
            cell?.loadData(media: presnter?.getItemAtIndexInSection(indexPath.section, indexPath.row))
                    // Configure the cell
            return cell ?? UICollectionViewCell()
            
        case .list:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constant.mediaSingleCellIdentifier, for: indexPath) as? MediaSingleCell
            cell?.loadData(media: presnter?.getItemAtIndexInSection(indexPath.section, indexPath.row))
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = presnter?.displayMode == .grid ? 3 : 1

        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize.zero }

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: presnter?.displayMode == .grid ? 210 : 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView ?? HeaderView()
                headerView.titleLabel.text = presnter?.getSection(indexPath.section)?.sectionName ?? ""
                return headerView

            default:
                return UICollectionReusableView()
            }
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 45)
        }
}

extension ListingScreenViewcontroller: ListingScreenViewControllerInput {
    func showMediaList() {
        self.listingCollectionView?.reloadData()
    }
}
