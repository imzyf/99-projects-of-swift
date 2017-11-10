import UIKit

class CustomViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var poster: Poster! {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    private func updateUI() {
        imageView.image = poster.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
