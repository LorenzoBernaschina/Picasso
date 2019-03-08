import UIKit

extension Inspector{
    ///This method draws buttons to manage some behavior of shapes
    func drawBehaviorButton(forImage image: UIImage, withSize size: CGFloat){
        let button = setButton(withSize: size)
        button.addTarget(self, action: #selector(Inspector.buttonPressed(sender:)), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        self.view.addSubview(button)
    }
    
    
    ///This method manages rotation, front/back position and deletion of shapes
    func buttonPressed(sender: UIButton){
        
        if (sender.currentImage?.isEqual(UIImage(named: "RotateLeftButton.png")))!{
            self.shape.angle = self.shape.rotateShape(byAngle: 15.0)
        }
        
        else if (sender.currentImage?.isEqual(UIImage(named: "RotateRightButton.png")))!{
            self.shape.angle = self.shape.rotateShape(byAngle: -15.0)
        }
        
        else if (sender.currentImage?.isEqual(UIImage(named: "FrontButton.png")))!{
            for node in self.scene.children{
                node.zPosition = 0
            }
            self.shape.zPosition = 1
        }
        
        else if (sender.currentImage?.isEqual(UIImage(named: "BackButton.png")))!{
            for node in self.scene.children{
                node.zPosition = 0
            }
            self.shape.zPosition = -1
        }
        
        else if (sender.currentImage?.isEqual(UIImage(named: "DeleteButton.png")))!{
            self.shape.removeFromParent()
            UIView.transition(with: self.scene.view!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {self.view.removeFromSuperview()},
                              completion: nil)
            self.scene.viewIsVisible = false
        }
    }
}

