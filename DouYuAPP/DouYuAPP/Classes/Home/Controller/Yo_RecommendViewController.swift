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

       loadData()
    }

    fileprivate lazy var recommendViewModel: Yo_RecommendViewModel = {
        return Yo_RecommendViewModel()
    }()
    
    fileprivate lazy var collectionViewModel: Yo_BaseCollectionViewModel = {
        return Yo_BaseCollectionViewModel()
    }()

}

extension Yo_RecommendViewController {
    fileprivate func loadData() {
        recommendViewModel.loadRecommendData { (dataArray) in
            
//            collectionViewModel.set(DataSource: { () -> [Yo_AnchorBaseGroup] in
//                return dataArray
//            }, completion: { 
//                
//            })
        }
    }
}
