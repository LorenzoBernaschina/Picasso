import SpriteKit
import CoreGraphics

public class Circle: Shape{
    //custom parameters for drawing the view inspector
    static let sizeLabels = ["Radius"]
    static let buttonImages = [UIImage(named: "FrontButton.png"),
                               UIImage(named: "BackButton.png"),
                               UIImage(named: "DeleteButton.png")]
    
    //to set circle radius
    public var radius: CGFloat{
        didSet{
            self.path = Circle.path(radius: self.radius)
        }
    }
    
    //circle initializer
    required public init(radius: CGFloat, position: CGPoint, color: UIColor) {
        self.radius = radius
        
        super.init(color: color)
        
        self.path = Circle.path(radius: self.radius)
        
        self.position = position
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(color: UIColor) {
        fatalError("init(color:) has not been implemented")
    }
    
    //sets the circle path
    class func path(radius: CGFloat) -> CGMutablePath{
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint.zero,
                    radius: radius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true)
        return path
    }

    
}

