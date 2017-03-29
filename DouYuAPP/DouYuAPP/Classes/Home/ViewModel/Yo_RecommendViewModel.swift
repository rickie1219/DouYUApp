//
//  Yo_RecommendViewModel.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/29.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit
import ObjectMapper

class Yo_RecommendViewModel: NSObject {
    
    public func loadRecommendData(_ finishCallBack: @escaping (_: [Yo_AnchorBaseGroup]) -> ()) {
        
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        let paramerers = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        LSYNetWorkTool.httpRequest(method: .get, url: GenerateUrl + "getbigDataRoom", parmaters: paramerers, resultClass: Yo_BaseResultModel.self) { (success, failure) in
            if let success = success {
                if !success.error {
                    self.bigDataRoomGroup.tag_name = "热门"
                    self.bigDataRoomGroup.icon_name = "home_header_hot"
                    let anchors = Mapper<Yo_AnchorModel>().mapArray(JSONArray: success.data!)
                    self.bigDataRoomGroup.anchors = anchors!
                    self.dataArray.insert(self.bigDataRoomGroup, at: 0)
                }
            }
            
            dGroup.leave()
        }
        dGroup.notify(queue: DispatchQueue.main){
            finishCallBack(self.dataArray)
        }
    }
    
    
    lazy var bigDataRoomGroup: Yo_AnchorBaseGroup = {
       return Yo_AnchorBaseGroup()
    }()
    
    lazy var dataArray: [Yo_AnchorBaseGroup] = {
       return [Yo_AnchorBaseGroup]()
    }()
}
