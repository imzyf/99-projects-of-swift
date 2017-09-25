import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        scrollDirection = .horizontal
        minimumLineSpacing = 20.0
        sectionInset = UIEdgeInsets(top: 0, left: SIDE_WIDTH, bottom: 0, right: SIDE_WIDTH)
        super.prepare()
    }
}
