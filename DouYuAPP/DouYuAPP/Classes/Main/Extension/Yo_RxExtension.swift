//
//  Yo_RxExtension.swift
//  DouYuAPP
//
//  Created by shying li on 2017/4/5.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension NotificationCenter {
    class func postNotifition(name: String) {
        self.default.post(name: Notification.Name(rawValue: name), object: nil)
    }
    
    class func addObserver(name: String, disposable: DisposeBag, subscribe: @escaping () -> ()) {
        self.default
            .rx.notification(Notification.Name(rawValue: baseContentViewName), object: nil).subscribe(onNext: { (notifition) in
                subscribe()
            }, onError: { (error) in
                subscribe()
            }, onCompleted: {
                subscribe()
            }, onDisposed: {
                print("onDisposed")
            }).addDisposableTo(disposable)
    }
}
