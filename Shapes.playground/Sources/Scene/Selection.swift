import SpriteKit
import CoreGraphics

public class Selection: Shape{
    
    //selection shape rect
    public var rect: CGRect?{
        didSet{
            self.path = Selection.path(rect: self.rect!)
        }
    }
    
    //selection shape initializer
    required public init(rect: CGRect, position: CGPoint, color: UIColor){
        self.rect = rect
        
        super.init(color: color)
        
        self.path = Selection.path(rect: self.rect!)
        
        self.position = position
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init(color: UIColor) {
        fatalError("init(color:) has not been implemented")
    }
    
    //draws the selection shape
    class func path(rect: CGRect) -> CGMutablePath{
        let path: CGMutablePath = CGMutablePath()
        path.addRect(rect)
        return path
    }
    
    
    
}

