import UIKit
import SpriteKit

let edgeDistanceX: CGFloat = 10
let edgeDistanceY: CGFloat = 10

let heightObject: CGFloat = 20

let minValueShapeSize: Float = 3.0
let maxValueShapeSize: Float = 200.0

class Inspector: UIViewController{

    let shape: Shape
    let frame: CGRect
    let scene: GameScene
    
    var colorSliders: [UISlider] = [UISlider]()
    
    var yPosition: CGFloat = edgeDistanceY
    var xPosition: CGFloat = edgeDistanceX
    
    required public init(forScene scene: GameScene, frame: CGRect, shape: Shape){
        self.scene = scene
        self.shape = shape
        self.frame = frame
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        //set the view
        setInspectorView()
        
        //color inspector
        drawColorSliderInspector(forColors: Shape.colorLabels)

        //color palette
        drawColorPaletteInspector(forColors: Shape.paletteColors)
        
        //shapes inspector
        if  self.shape.isKind(of: Circle.self) {
            drawShapeSizeInspector(forParameters: Circle.sizeLabels)
            drawButtonsBehaviorInspector(withImages: Circle.buttonImages as! [UIImage])
        }
            
        else if self.shape.isKind(of: Rectangle.self){
            drawShapeSizeInspector(forParameters: Rectangle.sizeLabels)
            drawButtonsBehaviorInspector(withImages: Rectangle.buttonImages as! [UIImage])
            
        }
            
        else if self.shape.isKind(of: Triangle.self){
            drawShapeSizeInspector(forParameters: Triangle.sizeLabels)
            drawButtonsBehaviorInspector(withImages: Triangle.buttonImages as! [UIImage])
        }
    }
    
    func setInspectorView(){
        self.view = UIView(frame: self.frame)
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        self.view.layer.borderWidth = 1.0
        let color = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        self.view.layer.borderColor = color.cgColor
        self.view.layer.cornerRadius = 15
    }
}

