//
//  Yo_RecommendCollectionViewModel.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/30.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_RecommendCollectionViewModel: Yo_BaseCollectionViewModel {

}


extension Yo_RecommendCollectionViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (kScreenW - 3 * 10) / 2
        let height = width / 1.7 + 30
        return CGSize(width: width, height: height)
    }
}
