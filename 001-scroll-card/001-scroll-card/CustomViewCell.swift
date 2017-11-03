import UIKit

class CustomViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func buildCell(poster: Poster) {
        let imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        imageView.image = poster.image
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
