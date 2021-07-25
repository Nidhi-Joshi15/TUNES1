//
//  HeaderView.swift
//  TUNESDEMO_VIP
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        // Customize here
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame.origin = CGPoint(x: 15, y: 10)
        titleLabel.frame.size.height = self.frame.size.height-20
        titleLabel.frame.size.width = self.frame.size.width-30
    }
    
    func loadData(_ title: String) {
        titleLabel.text = title
        titleLabel.textColor = .white
    }
}
