import UIKit

extension Inspector{
    
    ///This method draws labels and sliders to manage shape size
    func drawForShape(shape: Shape, withString string: String, andTag tag: Int){
        //draw labels
        let label = setLabel()
        label.text = string
        label.textAlignment = .left
        self.view.addSubview(label)
        
        //draw sliders
        let slider = setSlider()
        slider.minimumValue = minValueShapeSize
        slider.maximumValue = maxValueShapeSize
        slider.tintColor = .black
        
        if let circle = shape as? Circle {
            slider.addTarget(self, action: #selector(Inspector.setCircle(sender:)), for: .valueChanged)
            
            switch string {
            case "Radius":
                slider.value = Float(circle.radius)
            default: break
            }
        }
            
        else if let rectangle = shape as? Rectangle{
            slider.tag = tag
            
            slider.addTarget(self, action: #selector(Inspector.setRectangle(sender:)), for: .valueChanged)
            
            switch string {
            case "Width":
                slider.value = Float(rectangle.size.width)
            case "Height":
                slider.value = Float(rectangle.size.height)
            default: break
            }
        }
            
        else if let triangle = shape as? Triangle{
            slider.tag = tag
            slider.addTarget(self, action: #selector(Inspector.setTriangle(sender:)), for: .valueChanged)
            switch string {
            case "Width":
                slider.value = Float(triangle.size.width)
            case "Height":
                slider.value = Float(triangle.size.height)
            default: break
            }
        }
        
        self.view.addSubview(slider)
    }
    
    
    
    ///This method sets the radius of the circle
    func setCircle(sender: UISlider){
        if let circle = self.shape as? Circle{
            circle.radius = CGFloat(sender.value)
        }
    }
    
    
    ///This method sets width and height of the rectangle
    func setRectangle(sender: UISlider){
        if let rectangle = self.shape as? Rectangle{
            switch sender.tag {
            case 0:
                rectangle.size.width = CGFloat(sender.value)
            case 1:
                rectangle.size.height = CGFloat(sender.value)
            default: break
            }
        }
    }
    
    
    ///This method sets width and height of the triangle
    func setTriangle(sender: UISlider){
        if let triangle = self.shape as? Triangle{
            switch sender.tag {
            case 0:
                triangle.size.width = CGFloat(sender.value)
            case 1:
                triangle.size.height = CGFloat(sender.value)
            default: break
            }
        }
    }

    
}

