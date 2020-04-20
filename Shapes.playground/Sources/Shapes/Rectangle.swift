import SpriteKit
import CoreGraphics

public class Rectangle: Shape{
    
    //custom parameters for drawing the view inspector
    static let sizeLabels = ["Width", "Height"]
    static let buttonImages = [UIImage(named: "RotateLeftButton.png"),
                               UIImage(named: "RotateRightButton.png"),
                               UIImage(named: "FrontButton.png"),
                               UIImage(named: "BackButton.png"),
                               UIImage(named: "DeleteButton.png")]
    
    //to set rectangle size
    public var size: CGSize{
        didSet{
            self.path = Rectangle.path(size: self.size)
        }
    }
    
    //rectangle initializer
    required public init(size: CGSize, position: CGPoint, color: UIColor) {
        self.size = size
        
        super.init(color: color)
        
        self.path = Rectangle.path(size: self.size)
        
        self.position = position
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(color: UIColor) {
        fatalError("init(color:) has not been implemented")
    }
    
    //sets the rectangle path
    class func path(size: CGSize) -> CGMutablePath{
        let path: CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: -size.width/2, y: -size.height/2))
        path.addLine(to: CGPoint(x: size.width/2, y: -size.height/2))
        path.addLine(to: CGPoint(x: size.width/2, y: size.height/2))
        path.addLine(to: CGPoint(x: -size.width/2, y: size.height/2))
        path.addLine(to: CGPoint(x: -size.width/2, y: -size.height/2))
        return path
    }

}

