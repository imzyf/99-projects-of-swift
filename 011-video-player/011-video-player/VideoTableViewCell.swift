import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoSourceLabel: UILabel!
    @IBOutlet weak var videoInfoLabel: UILabel!
      
}

struct video {
    let image: String
    let title: String
    let source: String
}
