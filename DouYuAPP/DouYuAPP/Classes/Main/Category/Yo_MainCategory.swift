//
//  Yo_MainCategory.swift
//  SwiftProjectBaseFrame
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func register(TableView table: UITableView, identifier: String) {
        
        table.register(self, forCellReuseIdentifier: identifier)
    }
}

extension UIBarButtonItem {
    class func item(imageName name: String, target: Any?, action: Selector?) -> UIBarButtonItem {
        
        let itemButton = UIButton(type: UIButtonType.custom)
        itemButton.setImage(UIImage(named: name), for: UIControlState.normal)
        itemButton.setImage(UIImage(named: name + "_click"), for: UIControlState.highlighted)
        itemButton.sizeToFit()
        itemButton.addTarget(target, action: action!, for: UIControlEvents.touchUpInside)
        return UIBarButtonItem(customView: itemButton)
    }
}

extension UITableViewCell {
    func configure(Item: Any, indexPath: IndexPath) {
        
    }
}

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}

