import SpriteKit
import UIKit

public class Shape: SKShapeNode {
    
    //custom parameters for drawing the view inspector
    static let colorLabels = ["Color: R","Color: G","Color: B","Alpha"]
    static let paletteColors = [UIColor(red: 248.0/255.0, green: 231.0/255.0, blue: 28.0/255.0, alpha: 1.0),
                               UIColor(red: 243.0/255.0, green: 153.0/255.0, blue: 135.0/255.0, alpha: 1.0),
                               UIColor(red: 221.0/255.0, green: 93.0/255.0, blue: 69.0/255.0, alpha: 1.0),
                               UIColor(red: 204.0/255.0, green: 63.0/255.0, blue: 74.0/255.0, alpha: 1.0),
                               UIColor(red: 134.0/255.0, green: 100.0/255.0, blue: 163.0/255.0, alpha: 1.0),
                               UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0),
                               UIColor(red: 137.0/255.0, green: 175.0/255.0, blue: 192.0/255.0, alpha: 1.0),
                               UIColor(red: 81.0/255.0, green: 132.0/255.0, blue: 96.0/255.0, alpha: 1.0),
                               UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0),
                               UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)]
    
    //to set the shape color
    var shapeColor: UIColor{
        didSet{
            self.fillColor = self.shapeColor
        }
    }
    
    //to set the rotation angle of the shape
    var angle: CGFloat?
    
    
    //shape initializer
    required public init(color: UIColor) {
        
        self.shapeColor = color
        
        super.init()
        
        self.lineWidth = 0.0
        self.fillColor = self.shapeColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///This method rotates a shape
    func rotateShape(byAngle degrees: CGFloat) -> CGFloat{
        let radians: CGFloat = CGFloat(M_PI * Double(degrees))/180.0
        let rotate: SKAction = SKAction.rotate(byAngle: radians, duration: 0.5)
        self.run(rotate)
        return (180.0 * radians)/CGFloat(M_PI)
    }

}

