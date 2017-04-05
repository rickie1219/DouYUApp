//
//  Yo_HomeContentView.swift
//  DouYuAPP
//
//  Created by shying li on 2017/3/15.
//  Copyright © 2017年 李世洋. All rights reserved.
//

import UIKit

//protocol Yo_HomeContentViewDelegate: NSObjectProtocol {
//
//    func homeNavigationLeftBarDidClick()
//}

class Yo_HomeContentView: GenericView {
    
//    var contentViewDelegate: Yo_HomeContentViewDelegate?
    
    public var viewController: UIViewController?
    public var pageContentView: Yo_PageContentView!
    
    override func configureView() {
        super.configureView()

        
    }
  
    public lazy var pageTitleView: Yo_PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = Yo_PageTitleView(frame: titleFrame, titles: titles)
        return pageTitleView
    }()
}

extension Yo_HomeContentView {
    
    public func setupUI(partentVC: Yo_HomeViewController?) {
        addSubview(pageTitleView)
        pageTitleView.delegate = partentVC
        configureNavigation(viewController: partentVC!)
        configPageContentView(partentVC: partentVC)
        
    }
    
    fileprivate func configPageContentView(partentVC: Yo_HomeViewController?) {
        let childVcs = [Yo_RecommendViewController(), Yo_GameViewController(), Yo_AmuseViewController(), Yo_FunnyViewController()]
                let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let pageContentView = Yo_PageContentView(frame: CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH), chidrenViewControllers: childVcs, parentViewController: partentVC)
        pageContentView.delegate = partentVC!
        self.pageContentView = pageContentView
        addSubview(pageContentView)
    }
    
     // MARK: - 设置导航栏
    fileprivate func configureNavigation(viewController vc: Yo_HomeViewController) {
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem.item(imageName: "logo", target: vc, action: .logoDidClick)
        
        let searchItem = UIBarButtonItem.item(imageName: "btn_search", target: vc, action: .searchDidClick)
        let scanItem = UIBarButtonItem.item(imageName: "Image_scan", target: vc, action: .scanDidClick)
        let historyItem = UIBarButtonItem.item(imageName: "image_my_history", target: vc, action: .historyDidClick)
        vc.navigationItem.rightBarButtonItems = [historyItem, scanItem, searchItem]
    }
    
    public func setDelegate(ViewModel vm: Yo_HomeViewModel) {
//        contentViewDelegate = vm
    }
   
    

}

private extension Selector {
    static let logoDidClick = #selector(Yo_HomeViewController.logoDidClick)
    static let searchDidClick = #selector(Yo_HomeViewController.searchDidClick)
    static let scanDidClick = #selector(Yo_HomeViewController.scanDidClick)
    static let historyDidClick = #selector(Yo_HomeViewController.historyDidClick)
}
