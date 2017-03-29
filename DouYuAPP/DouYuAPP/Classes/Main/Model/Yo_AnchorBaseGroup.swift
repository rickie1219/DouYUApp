//
//  Yo_AnchorBaseGroup.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/28.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_AnchorBaseGroup: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    var icon_name : String = "home_header_normal"
    lazy var anchors : [Yo_AnchorModel] = [Yo_AnchorModel]()
}
