//
//  Yo_RecommendNormalCell.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/30.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_RecommendNormalCell: Yo_BaseCollectionViewCell {
    
    override func configureView() {
        super.configureView()
        
        setupUI()
    }
    
    fileprivate lazy var anchorName: UILabel = {[weak self] in
        let anchorName = UILabel()
        anchorName.textColor = UIColor.white
        anchorName.font = UIFont.systemFont(ofSize: 11)
        self?.coverImage.addSubview(anchorName)
        return anchorName
        }()
    
    fileprivate lazy var onLineLabel: UILabel = {[weak self] in
        let onLineLabel = UILabel()
        onLineLabel.textColor = UIColor.white
        onLineLabel.font = UIFont.systemFont(ofSize: 11)
        self?.coverImage.addSubview(onLineLabel)
        return onLineLabel
    }()
    
    fileprivate lazy var onLineIcon: UIImageView = {[weak self] in
        let onLineIcon = UIImageView(image: UIImage(named: "Image_online"))
        self?.coverImage.addSubview(onLineIcon)
        return onLineIcon
    }()
    
    fileprivate lazy var roomIcon: UIImageView = {[weak self] in
        let roomIcon = UIImageView(image: UIImage(named: "home_live_cate_normal"))
        self?.contentView.addSubview(roomIcon)
        return roomIcon
        }()
    
    fileprivate lazy var roomName: UILabel = {[weak self] in
        let roomName = UILabel()
        roomName.font = UIFont.systemFont(ofSize: 11)
        self?.contentView.addSubview(roomName)
        return roomName
    }()
}

extension Yo_RecommendNormalCell {
    override func configure(Item: Any, indexPath: IndexPath) {
        let model = Item as! Yo_AnchorModel
        coverImage.kf.setImage(with: URL(string: model.vertical_src))
        anchorName.text = model.nickname
        onLineLabel.text = "\(model.online)在线"
        roomName.text = model.room_name
    }
}

extension Yo_RecommendNormalCell {
    
    fileprivate func setupUI() {
        anchorName.snp.makeConstraints { (maker) in
            maker.left.equalTo(coverImage).offset(LayoutScale.width(6))
            maker.bottom.equalTo(coverImage).offset(LayoutScale.width(-8))
        }
        
        onLineLabel.snp.makeConstraints { (maker) in
            maker.right.equalTo(coverImage).offset(LayoutScale.width(-6))
            maker.bottom.equalTo(anchorName.snp.bottom)
        }
        
        onLineIcon.snp.makeConstraints { (maker) in
            maker.right.equalTo(onLineLabel.snp.left).offset(-1)
            maker.bottom.equalTo(onLineLabel.snp.bottom)
        }
        
        roomIcon.snp.makeConstraints { (maker) in
            maker.left.equalTo(contentView.snp.left)
            maker.bottom.equalTo(contentView.snp.bottom).offset(-12)
            maker.width.equalTo(14)
        }
        
        roomName.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(roomIcon.snp.centerY)
            maker.left.equalTo(roomIcon.snp.right).offset(LayoutScale.width(5))
            maker.right.equalTo(contentView.snp.right)
            
        }
    }
}
