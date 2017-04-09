# DouYUApp
仿斗鱼app
MVVM是一种什么样的模式在这篇文章中就不解释了，写这篇文章的目的我个人对MVVM模式的一点理解，下面直入正题：
###项目结构

![项目结构](http://upload-images.jianshu.io/upload_images/2286932-74f30e181ca51539.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
其中对ViewModel模块包括代理方法的ViewModel和业务逻辑的ViewModel，着重介绍一下我封装的*Yo_BaseCollectionViewModel*
###ViewModel
*Yo_BaseCollectionViewModel*类中是CollectionView的代理方法，以往这些代理方法都写在Controller中，个人感觉这样的Controller并不够清爽，Controller仅需要负责各模块之间的调度即可。我通过
```
public func set(DataSource data:() -> [Yo_AnchorBaseGroup], completion: () -> ()) {
dataSoureArr.append(contentsOf: data())
completion()
}```
闭包向该ViewModel传值，调用`completion()`闭包对传值后进行下一步处理，如刷新。
*Yo_RecommendViewModel*类中是网络请求和一写业务的处理
```
public func loadRecommendData(_ finishCallBack: @escaping (_: [Yo_AnchorBaseGroup], [Yo_AnchorBaseGroup]) -> ()) {
        
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        let paramerers = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        LSYNetWorkTool.httpRequest(method: .get, url: GenerateUrl + "getbigDataRoom", parmaters: paramerers, resultClass: Yo_BaseResultModel.self) { (success, failure) in
            if let success = success {
                if !success.error {
                    self.bigDataRoomGroup.tag_name = "热门"
                    self.bigDataRoomGroup.icon_name = "home_header_hot"
                    let anchors = Mapper<Yo_AnchorModel>().mapArray(JSONArray: success.data!)
                    self.bigDataRoomGroup.room_list = anchors!
                }
            }
            dGroup.leave()
        }
        
        dGroup.enter()
        LSYNetWorkTool.httpRequest(method: .get, url: GenerateUrl + "getVerticalRoom", parmaters: paramerers, resultClass: Yo_BaseResultModel.self) { (success, failure) in
            if let success = success {
                if !success.error {
                    self.verticalRoomGroup.tag_name = "颜值"
                    self.verticalRoomGroup.icon_name = "home_header_phone"
                    let anchors = Mapper<Yo_AnchorModel>().mapArray(JSONArray: success.data!)
                    self.verticalRoomGroup.room_list = anchors!
                }
            }
            dGroup.leave()
        }
        
        dGroup.enter()
        LSYNetWorkTool.httpRequest(method: .get, url: GenerateUrl + "getHotCate", parmaters: paramerers, resultClass: Yo_BaseResultModel.self) { (success, failure) in
            if let success = success {
                self.gameGroups = Mapper<Yo_AnchorBaseGroup>().mapArray(JSONArray: success.data!)!
            }
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main){
            
            self.dataArray.insert(self.bigDataRoomGroup, at: 0)
            self.dataArray.append(self.verticalRoomGroup)
            self.dataArray.append(contentsOf: self.gameGroups)
            
            self.gameArray.append(contentsOf: self.dataArray)
            self.gameArray.remove(at: 0)
            self.gameArray.remove(at: 0)
            let moreGroup = Yo_AnchorBaseGroup()
            moreGroup.tag_name = "更多"
            self.gameArray.append(moreGroup)
            finishCallBack(self.dataArray, self.gameArray)
            NotificationCenter.postNotifition(name: baseContentViewName)
        }
    }
    
    public func loadCycleData(_ finishCallBack: @escaping (_: [Yo_HomeCycleModel]?) -> ()) {
    
        LSYNetWorkTool.httpRequest(method: .get, url: "http://www.douyutv.com/api/v1/slide/6", parmaters: ["version" : "2.471"], resultClass: Yo_BaseResultModel.self) { (success, failure) in
            if let success = success {
                let cycleModelArray = Mapper<Yo_HomeCycleModel>().mapArray(JSONArray: success.data!)
                finishCallBack(cycleModelArray)
            }
        }
    }
```
###View
为追求极致的Controller，将Controller的View 也处理了出来，凡是需要在Controller上创建的控件都写在该类中：
```
class Yo_RecommendContentView: Yo_BaseContentView {
    
    override func configureView() {
        super.configureView()
    }
    
    lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top:kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        return collectionView
        }()
    
    lazy var cycleView: Yo_HomeCycleView = {[weak self] in
        let cycleView = Yo_HomeCycleView(frame: CGRect.zero)
        cycleView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: cycleViewCellID)
        cycleView.itemSize = .zero
        cycleView.automaticSlidingInterval = 3.0
        self?.collectionView.addSubview(cycleView)
        return cycleView
    }()
    
    lazy var gameView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: kGameViewH)
        layout.scrollDirection = .horizontal
        
        let gameView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        gameView.backgroundColor = UIColor.white
        gameView.showsHorizontalScrollIndicator = false
        gameView.showsVerticalScrollIndicator = false
        self?.collectionView.addSubview(gameView)
        return gameView
        }()
   
}
```
###Controller
controller中负责*View*和*ViewModel*之间的调度
```
class Yo_RecommendViewController: GenericViewController<Yo_RecommendContentView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.setupUI()
        
        collectionViewModel.registerCell { () -> [String : UICollectionViewCell.Type] in
            return [normalCellID: Yo_RecommendNormalCell.self, prettyCellID: Yo_RecommendPrettyCell.self]
        }
        
        collectionViewModel.registerReusableView(Kind: UICollectionElementKindSectionHeader) { () -> [String : UIView.Type] in
            return [sectionHeaderID: Yo_HomeSectionHeaderView.self]
        }
        
        gameViewModel.registerCell { () -> [String : UICollectionViewCell.Type] in
            return [HomeGameViewCell: Yo_HomeGameViewCell.self]
        }
        
        loadData()
    }
    
    fileprivate lazy var recommendViewModel: Yo_RecommendViewModel = {
        return Yo_RecommendViewModel()
    }()
    
    fileprivate lazy var collectionViewModel: Yo_RecommendCollectionViewModel = {[weak self] in
        return Yo_RecommendCollectionViewModel(CollectionView: (self?.contentView.collectionView)!)
        }()
    
    fileprivate lazy var cycleViewModel: Yo_HomeCycleViewModel = {[weak self] in
        let cycleViewModel = Yo_HomeCycleViewModel(CycleView: (self?.contentView.cycleView)!)
        return cycleViewModel
        }()
    
    fileprivate lazy var gameViewModel: Yo_GameViewModel = {[weak self] in
        return Yo_GameViewModel(CollectionView: (self?.contentView.gameView)!)
        }()
}
```
其中
```
GenericViewController<Yo_RecommendContentView>
```
是泛型语法，很简单，意思就是该Controller的View是* Yo_RecommendContentView*
分享一个小框架（用于实现上面的这种模式）：Demo中 **ConfigureUI**文件夹（非我所创，学习自SwiftGG）
###运行效果

![运行效果](http://upload-images.jianshu.io/upload_images/2286932-b8943c72ab5a474f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
个人觉得这种架构模式思路清晰，藕合性低，各模块分工明确，该项目仅仅是个人的一些小想法。
