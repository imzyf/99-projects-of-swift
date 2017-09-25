import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SIDE_WIDTH:CGFloat = 50

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        createRootView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createRootView() {
        let layout = CustomLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH-SIDE_WIDTH*2, height: SCREEN_HEIGHT/2)
  
        let rect = CGRect(x: 0, y: 0, width:SCREEN_WIDTH , height: SCREEN_HEIGHT)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        // 隐藏水平滚动轴
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
}

// MARK: -- delegate and datasource
extension ViewController:
    UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomViewCell
        cell.backgroundColor = .white
        cell.lable?.text = "\(indexPath.row)/\(10)"
        
        return cell
    }
}



