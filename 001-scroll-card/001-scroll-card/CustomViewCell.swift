import UIKit

class CustomViewCell: UICollectionViewCell {
    var lable: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rect = CGRect(
            // 居中
            x: (SCREEN_WIDTH-SIDE_WIDTH*2)/2-100/2,
            y: 100,
            width: 100,
            height: 100
        )
        
        lable = UILabel(frame: rect)
        lable?.backgroundColor = .orange
        lable?.textAlignment = .center
        
        self.addSubview(lable!)
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
