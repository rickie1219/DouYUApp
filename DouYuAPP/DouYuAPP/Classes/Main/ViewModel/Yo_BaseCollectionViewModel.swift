
//
//  Yo_BaseCollectionViewModel.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/28.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
let kPrettyCellID = "kPrettyCellID"

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class Yo_BaseCollectionViewModel: NSObject {

    public func configure(collectionView collection: UICollectionView, cellClass: UICollectionViewCell.Type, reuseIdentifier: String) {
       
        collection.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        collection.dataSource = self
        collection.delegate = self
    }
    
    public func set(DataSource data:() -> [Yo_AnchorBaseGroup], completion: () -> ()) {
        dataSoureArr.append(contentsOf: data())
        completion()
    }
    
    public lazy var dataSoureArr: [Yo_AnchorBaseGroup] = {
        let arr = [Yo_AnchorBaseGroup]()
        return arr
    }()
}

extension Yo_BaseCollectionViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! Yo_BaseCollectionViewCell
        cell.configure(Item: dataSoureArr[indexPath.section].anchors[indexPath.item], indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSoureArr[section].anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSoureArr.count
    }
}

