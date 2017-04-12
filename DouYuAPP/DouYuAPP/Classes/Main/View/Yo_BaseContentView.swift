//
//  Yo_BaseContentView.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/28.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Yo_BaseContentView: GenericView {
    
    fileprivate let disposeBag = DisposeBag()
    override func configureView() {
        super.configureView()
        
        addNotifitionCenter()
    }
}

extension Yo_BaseContentView: AddIndicatorViewProtocol {
    
    fileprivate func addNotifitionCenter() {
        NotificationCenter.addObserver(name: baseContentViewName, disposable: disposeBag) { 
            self.stopAnimations()
        }
    }
}
