import UIKit

extension Inspector{
    ///This method sets labels frame and sets the new yPosition
    func setLabel() -> UILabel{
        let currentYPosition = self.yPosition
        self.yPosition += (heightObject + edgeDistanceY)
        return UILabel(frame: CGRect(x: self.xPosition,
                                     y: currentYPosition,
                                     width: self.view.frame.size.width - (edgeDistanceX * 2),
                                     height: heightObject))
    }
    
    ///This method sets sliders frame and sets the new yPosition
    func setSlider() -> UISlider{
        let currentYPosition = self.yPosition
        self.yPosition += (heightObject + edgeDistanceY)
        return UISlider(frame: CGRect(x: self.xPosition,
                                      y: currentYPosition,
                                      width: self.view.frame.size.width - (edgeDistanceX * 2),
                                      height: heightObject))
    }
    
    ///This method sets buttons
    func setButton(withSize sizeButton: CGFloat) -> UIButton{
        let currentXPosition = self.xPosition
        self.xPosition += (sizeButton + edgeDistanceX)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: currentXPosition,
                              y: self.yPosition,
                              width: sizeButton,
                              height: sizeButton)
        return button
    }
}

