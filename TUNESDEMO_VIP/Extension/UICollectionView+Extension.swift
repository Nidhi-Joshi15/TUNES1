//
//  UICollectionView+Extension.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//
import Foundation
import UIKit

extension UICollectionView {
    func registerNib(_ nibName: String, bundle: Bundle? = nil) {
        register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: nibName)
    }
}
