import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SIDE_WIDTH:CGFloat = 50

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource = [Poster]()
    
    let flowLayout = UICollectionViewFlowLayout()
    let customLayout = CustomLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...5 {
            dataSource.append(Poster(image: UIImage(named: "Photo\(i)")))
        }
        for i in 1...5 {
            dataSource.append(Poster(image: UIImage(named: "Photo\(i)")))
        }
        
        createRootView()
        createSegmentView()
    }
    
    func createRootView() {
        
        // init flow layout
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: SIDE_WIDTH/2, bottom: 0, right: SIDE_WIDTH/2)
        flowLayout.minimumLineSpacing = 20
        
        // init coustom layout
        customLayout.scrollDirection = .horizontal
        customLayout.sectionInset = UIEdgeInsets(top: 0, left: SIDE_WIDTH, bottom: 0, right: SIDE_WIDTH)
        // 间距小一点，因为有水平的缩放。
        customLayout.minimumLineSpacing = 10
        
        // init collection
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 注册 cell
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: "cell")
        // 设置背景
        collectionView.backgroundView = createBackgroundView()
        // 隐藏水平滚动轴
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    func createBackgroundView() -> UIView {
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = #imageLiteral(resourceName: "bg")
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView  = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgImageView.frame
        bgImageView.addSubview(blurView)
        
        return bgImageView
    }
    
    func createSegmentView() {
        let segmentView = UISegmentedControl(items: ["FlowLayout","CustomLayout"])
        segmentView.frame = CGRect(x:10, y:50, width:SCREEN_WIDTH-20, height:segmentView.bounds.height)
        segmentView.selectedSegmentIndex = 0
        segmentView.tintColor = .white
        segmentView.addTarget(self, action: #selector(segmentDidchange(sender:)), for: .valueChanged)
        
        self.view.addSubview(segmentView)
    }
    
    @objc func segmentDidchange(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            collectionView.collectionViewLayout = customLayout
        default:
            collectionView.collectionViewLayout = flowLayout
        }
    } 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: -- delegate and datasource
extension ViewController: UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomViewCell
        cell.poster = dataSource[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 220 360 尺寸按比例
        return CGSize(width: (SCREEN_HEIGHT*0.6/36*22), height: (SCREEN_HEIGHT*0.6))
    }
}
