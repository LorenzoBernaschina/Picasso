import UIKit

extension Inspector{
    
    ///This method draws all the RGB sliders to manage the colors of the shapes
    func drawColorSliderInspector(forColors colors:[String]){
        for i in 0..<colors.count{
            drawColorSlider(forColor: colors[i], withTag: i)
        }
    }
    
    
    ///This method draws the color palette
    func drawColorPaletteInspector(forColors colors:[UIColor]){
        //This line gets the mid index of the array
        let midpoint = colors.count/2
        
        //Create two slices of the original array
        let firstLine = colors.prefix(upTo: midpoint)
        let secondLine = colors.suffix(from: midpoint)
        
        drawPalette(forElements: firstLine)
        drawPalette(forElements: secondLine)
    }
    
    
    ///This method draws a line of buttons with some standard colors
    func drawPalette(forElements elements: ArraySlice<UIColor>){
        //set the size of the buttons based on the number of elements on the line and the view width
        let size = (self.view.frame.size.width - edgeDistanceX * CGFloat(elements.count + 1))/CGFloat(elements.count)
        
        //draw the first line
        for i in elements.startIndex..<elements.endIndex{
            drawColorPalette(forColor: elements[i], withSize: size)
        }
        
        setNewPosition(afterButtonWithSize: size)
    }
    
    
    ///This method draws all the sliders to manage the size of the shapes
    func drawShapeSizeInspector(forParameters parameters: [String]){
        for i in 0..<parameters.count{
            drawForShape(shape: self.shape, withString: parameters[i], andTag: i)
        }
    }
    
    
    ///This method draws a line of buttons to manage some behaviors of shapes such as rotation, deletion and zPosition
    func drawButtonsBehaviorInspector(withImages images: [UIImage]){
        let size = (self.view.frame.size.width - edgeDistanceX * CGFloat(images.count + 1))/CGFloat(images.count)
        for i in 0..<images.count{
            drawBehaviorButton(forImage: images[i], withSize: size)
        }
        
        setNewPosition(afterButtonWithSize: size)
    }

    
    ///This method reset xPosition and update the yPosition for the next item after having drawn a line of buttons
    func setNewPosition(afterButtonWithSize size: CGFloat){
        self.xPosition = edgeDistanceX
        self.yPosition += (size + edgeDistanceY)
    }
}

