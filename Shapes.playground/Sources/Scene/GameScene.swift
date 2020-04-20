import SpriteKit

public class GameScene: SKScene{
    //touches
    var touch: UITouch?
    var touchedNode: SKNode?
    
    //inspector view
    var viewController: Inspector?
    var viewIsVisible: Bool = false
    
    //selection for multiple shapes
    var shapeSelection: Selection?
    var panLocationStart = CGPoint()
    var panLocationDrag = CGPoint()
    var panLocationFinish = CGPoint()
    
    //gestures
    var doubleTap = UITapGestureRecognizer() //to open the inspector
    var dragging = UIPanGestureRecognizer() //to make the selection
    
    //to manage multiple selection
    var selectedNodes: [SKNode] = [SKNode]()
    var groupSelection = false
    
    //size of the inspector view
    let viewInspectorWidth: CGFloat = 300
    let viewInspectorHeight: CGFloat = 560
    
    
    override public init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        //setup the scene here
        self.doubleTap = UITapGestureRecognizer(target: self, action: #selector(GameScene.doubleTap(sender:)))
        self.doubleTap.numberOfTapsRequired = 2
        self.view?.addGestureRecognizer(self.doubleTap)
        
        self.dragging = UIPanGestureRecognizer(target: self, action: #selector(GameScene.dragging(sender:)))
        self.dragging.minimumNumberOfTouches = 1
        self.view?.addGestureRecognizer(self.dragging)
        
        self.backgroundColor = .white
    }
    
    //to open the inspector
    @objc func doubleTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            
            var touchLocation: CGPoint = sender.location(in: self.view)
            touchLocation = self.convertPoint(fromView: touchLocation)
            
            let shape = self.atPoint(touchLocation)
            
            //the double tap is inside a shape -> open the Inspector to manipulate shape attributes
            if shape.isKind(of: Shape.self) && !self.viewIsVisible {
                let inspectorX: CGFloat
                let inspectorY: CGFloat
                
                //decide where to draw the view (left or right of the screen)
                if  touchLocation.x <= self.view!.frame.size.width/2 {
                    inspectorX = self.view!.frame.size.width/2
                    inspectorY = 10
                }else{
                    inspectorX = 10
                    inspectorY = 10
                }
                
                //set the Inspector for the selected shape
                let frame = CGRect(x: inspectorX, y: inspectorY, width: viewInspectorWidth, height: viewInspectorHeight)
                self.viewController = Inspector(forScene: self, frame: frame, shape: shape as! Shape)
                let view = self.viewController?.view
                UIView.transition(with: self.view!,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {self.view?.addSubview(view!)},
                                  completion: nil)
                
                self.viewIsVisible = true
            }
        }
    }

    
    //to make the selection
    @objc func dragging(sender: UIPanGestureRecognizer){
        if sender.state == .began{
            self.selectedNodes.removeAll()
            
            self.panLocationStart = sender.location(in: self.view)
            self.panLocationStart = self.convertPoint(fromView: self.panLocationStart)
            
            //init selection shape
            let color = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 0.9)
            self.shapeSelection = Selection.init(rect: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                 position: self.panLocationStart,
                                                 color: color)
            
            self.addChild(self.shapeSelection!)
        }
        
        if sender.state == .changed{
            //gets position of the drag
            self.panLocationDrag = sender.location(in: self.view)
            self.panLocationDrag = self.convertPoint(toView: self.panLocationDrag)
            
            //draws selection based on the position of the dragging
            self.shapeSelection?.rect?.size.width = self.panLocationDrag.x - self.panLocationStart.x
            self.shapeSelection?.rect?.size.height = self.panLocationDrag.y - self.panLocationStart.y
        }
        
        if sender.state == .ended{
            self.panLocationFinish = sender.location(in: self.view)
            self.panLocationFinish = self.convertPoint(fromView: self.panLocationFinish)
            
            //creates an array with all the shapes involved in the selection
            for node in self.children {
                if (self.shapeSelection?.frame.intersects(node.frame))! && node.frame != self.shapeSelection?.frame {
                    self.selectedNodes.append(node)
                }
            }
            
            self.shapeSelection?.removeFromParent()
        }
    }

    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //wherever you touch, if the view inspector is visible remove it
            if self.viewIsVisible{
                UIView.transition(with: self.view!,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {self.viewController?.view.removeFromSuperview()},
                                  completion: nil)
                self.viewIsVisible = false
            }
            
            //if you touch inside a shape
            if atPoint(touch.location(in: self)).isKind(of: SKShapeNode.self){
                
                //disable dragging gesture to avoid conflicts
                self.dragging.isEnabled = false
                
                let location = touch.location(in: self)
                self.touchedNode = atPoint(location)
                
                //check if the touched node is part of a group selection
                for nodesSelected in self.selectedNodes{
                    if self.touchedNode?.frame == nodesSelected.frame{
                        self.groupSelection = true
                        break
                    }
                }

                self.touch = touch as UITouch
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if self.touch != nil{
                if touch as UITouch == self.touch!{
                    
                    let location = touch.location(in: self)
                    
                    //if the node selected is part of a group selection, move all the group objects
                    if self.groupSelection{
                        let offsetX = location.x - (self.touchedNode?.position.x)!
                        let offsetY = location.y - (self.touchedNode?.position.y)!
                        for node in self.selectedNodes{
                            node.position.x += offsetX
                            node.position.y += offsetY
                        }
                    }else{
                        //else move just the node selected
                        self.touchedNode?.position = location
                    }
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if self.touch != nil{
                if touch as UITouch == self.touch{
                    self.touch = nil
                    self.touchedNode = nil
                    //remove group selection after dragging
                    if self.groupSelection {
                        self.selectedNodes.removeAll()
                        self.groupSelection = false
                    }
                }
                self.dragging.isEnabled = true
            }
        }
    }
    
}
