//
//  Yo_HomeViewController.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/14.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

class Yo_HomeViewController: GenericViewController<Yo_HomeContentView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.configureNavigation(viewController: self)
        //        contentView.setDelegate(ViewModel: homeViewModel)
        
        contentView.configPageContentView(parentViewController: self)
        
        
    }
  
    
    public func logoDidClick() {
        print("logo")
    }
    
    public func searchDidClick() {
        print("search")
    }
    
    public func historyDidClick() {
        print("history")
    }
    
    public func scanDidClick() {
        print("scan")
    }
    
    private lazy var homeViewModel: Yo_HomeViewModel = {
        let viewModel = Yo_HomeViewModel()
        return viewModel
    }()
}


