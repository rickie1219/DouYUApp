//
//  Yo_RecommendViewController.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/28.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_RecommendViewController: Yo_BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewModel.registerCell { () -> [String : UICollectionViewCell.Type] in
            return [normalCellID: Yo_RecommendNormalCell.self, prettyCellID: Yo_RecommendPrettyCell.self]
        }
        
        collectionViewModel.registerReusableView(Kind: UICollectionElementKindSectionHeader) { () -> [String : UIView.Type] in
            return [sectionHeaderID: Yo_HomeSectionHeaderView.self]
        }
        
        loadData()
    }

    fileprivate lazy var recommendViewModel: Yo_RecommendViewModel = {
        return Yo_RecommendViewModel()
    }()
    
    fileprivate lazy var collectionViewModel: Yo_RecommendCollectionViewModel = {[weak self] in
        return Yo_RecommendCollectionViewModel(CollectionView: (self?.contentView.collectionView)!)
    }()

}

extension Yo_RecommendViewController {
    fileprivate func loadData() {
        recommendViewModel.loadRecommendData {[weak self] (dataArray) in
            
            self?.collectionViewModel.set(DataSource: { () -> [Yo_AnchorBaseGroup] in
                return dataArray
            }, completion: { 
                self?.contentView.collectionView.reloadData()
            })
        }
    }
}
