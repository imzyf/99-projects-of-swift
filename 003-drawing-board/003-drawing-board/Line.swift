import UIKit

class Line {
    
    var startPoint: CGPoint
    var endPoint: CGPoint
    var color: UIColor
    
    init(start: CGPoint, end: CGPoint, color: UIColor) {
        self.startPoint = start
        self.endPoint = end
        self.color = color
    }
}
