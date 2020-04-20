import UIKit

//snippet for getting RGB values
extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}

extension Inspector{
    
    ///This method draws labels and sliders to manage the shape color inside inspector
    func drawColorSlider(forColor color: String, withTag tag: Int){
        
        let label = setLabel()
        label.text = color
        label.textAlignment = .left
        self.view.addSubview(label)
        
        let slider = setSlider()
        slider.addTarget(self, action: #selector(Inspector.didMoveColorSlider(sender:)), for: .valueChanged)
        switch color {
        case "Color: R":
            let color = UIColor(red: 204.0/255.0, green: 63.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            slider.tintColor = color
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.value = Float(self.shape.shapeColor.components.red)
        case "Color: G":
            let color = UIColor(red: 70.0/255.0, green: 162.0/255.0, blue: 90.0/255.0, alpha: 1.0)
            slider.tintColor = color
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.value = Float(self.shape.shapeColor.components.green)
        case "Color: B":
            let color = UIColor(red: 33.0/255.0, green: 57.0/255.0, blue: 213.0/255.0, alpha: 1.0)
            slider.tintColor = color
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.value = Float(self.shape.shapeColor.components.blue)
        case "Alpha":
            let color = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            slider.tintColor = color
            slider.minimumValue = 0.2
            slider.maximumValue = 1.0
            slider.value = Float(self.shape.shapeColor.components.alpha)
        default:
            break
        }
        slider.tag = tag
        self.view.addSubview(slider)
        
        self.colorSliders.append(slider)
    }
    
    
    ///This method manages the shape color in case of some changes in RGB values
    @objc func didMoveColorSlider(sender: UISlider){
        
        var redColor = self.shape.shapeColor.components.red
        var greenColor = self.shape.shapeColor.components.green
        var blueColor = self.shape.shapeColor.components.blue
        var alphaColor = self.shape.shapeColor.components.alpha
        
        switch sender.tag {
        case 0:
            redColor = CGFloat(sender.value)
        case 1:
            greenColor = CGFloat(sender.value)
        case 2:
            blueColor = CGFloat(sender.value)
        case 3:
            alphaColor = CGFloat(sender.value)
        default: break
        }
        
        self.shape.shapeColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: alphaColor)
    }
    
    ///This method draws a color palette with some standard colors to fill shapes
    func drawColorPalette(forColor color: UIColor, withSize size: CGFloat){
        let button = setButton(withSize: size)
        button.addTarget(self, action: #selector(Inspector.colorPressed(sender:)), for: .touchUpInside)
        button.backgroundColor = color
        button.layer.cornerRadius = size/2
        self.view.addSubview(button)
    }
    
    
    @objc func colorPressed(sender: UIButton){
        self.shape.shapeColor = sender.backgroundColor!
        
        for i in 0..<self.colorSliders.count{
            switch self.colorSliders[i].tag {
            case 0:
                UIView.animate(withDuration: 0.5, animations: {
                    self.colorSliders[i].setValue(Float(self.shape.shapeColor.components.red), animated: true)
                })
            case 1:
                UIView.animate(withDuration: 0.5, animations: {
                    self.colorSliders[i].setValue(Float(self.shape.shapeColor.components.green), animated: true)
                })
            case 2:
                UIView.animate(withDuration: 0.5, animations: {
                    self.colorSliders[i].setValue(Float(self.shape.shapeColor.components.blue), animated: true)
                })
            case 3:
                UIView.animate(withDuration: 0.5, animations: {
                    self.colorSliders[i].setValue(Float(self.shape.shapeColor.components.alpha), animated: true)
                })
            default: break
            }
        }
    }

    
}

