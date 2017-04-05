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
    
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
        }()
    
}

extension Yo_BaseContentView {
    fileprivate func addNotifitionCenter() {
        NotificationCenter.default
            .rx.notification(Notification.Name(rawValue: baseContentViewName), object: nil).subscribe(onNext: { (notifition) in
                self.stopAnimations()
            }, onError: { (error) in
                print("error\(error)")
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed")
            }).addDisposableTo(self.disposeBag)
    }
    
    public func addIndicatorView() {
        animImageView.isHidden = false
        addSubview(animImageView)
        animImageView.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalTo(self)
        }
        animImageView.startAnimating()
    }
    
    fileprivate func stopAnimations() {
        self.animImageView.isHidden = true
        animImageView.stopAnimating()
    }
}
