//
//  Yo_BaseContentView.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/28.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_BaseContentView: GenericView {
    
    
    override func configureView() {
        super.configureView()
    }
    
    lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
        }()
}

extension Yo_BaseContentView {
    public func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.top.bottom.left.right.equalTo(self)
        }
    }
}
