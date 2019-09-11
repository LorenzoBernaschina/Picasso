
//: ![](Cover.pdf)

import SpriteKit
import PlaygroundSupport
import UIKit
import AVFoundation

let rootViewWidth: CGFloat = 800
let rootViewHeight: CGFloat = 700

let buttonX: CGFloat = 10
let buttonY: CGFloat = 640
let buttonWidth: CGFloat = 50
let buttonHeight: CGFloat = 50

class GameViewController: UIViewController{
    
    let scene: GameScene = GameScene(size: CGSize(width: rootViewWidth, height: rootViewHeight))
    
    var soundtrack: AVAudioPlayer!
    
    override func loadView() {
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: rootViewWidth, height: rootViewHeight))
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSKView()
        
        drawButtons()
        
        playBackgroundMusic()
    }
    
    ///This method sets the parameters of the SKView and adds the scene object to the view
    func setSKView(){
        guard let skView = self.view as? SKView else {return}
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }
    
    ///This method draws the buttons of the main view
    func drawButtons(){
        guard let skView = self.view as? SKView else {return}
        
        //set and add buttons for drawing shapes to the view
        let icons = ["RectangleButton.png", "CircleButton.png", "TriangleButton.png"]
        for i in 0..<icons.count{
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: buttonX + (buttonWidth + buttonX) * CGFloat(i),
                                  y: buttonY,
                                  width: buttonWidth,
                                  height: buttonHeight)
            button.setImage(UIImage(named: icons[i]), for: .normal)
            button.addTarget(self, action: #selector(GameViewController.drawShape(sender:)), for: .touchUpInside)
            button.tag = i
            skView.addSubview(button)
        }
    }
    
    ///This method draws new shapes on the screen when a button is pressed
    @objc func drawShape(sender: UIButton){
        switch sender.tag {
        case 0:
            let color = UIColor(red: 248.0/255.0, green: 231.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            let rectangle = Rectangle(size: CGSize(width: 100, height: 100),
                                      position: CGPoint(x: 300, y: 100),
                                      color: color)
            scene.addChild(rectangle)
        case 1:
            let color = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
            let circle = Circle(radius: 30.0,
                                position: CGPoint(x: 200, y: 200),
                                color: color)
            scene.addChild(circle)
        case 2:
            let color = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            let triangle = Triangle(size: CGSize(width: 100, height: 100),
                                    position: CGPoint(x: 300, y: 300),
                                    color: color)
            scene.addChild(triangle)
        default: break
        }
    }
    
    ///This method sets the AVAudioPlayer object to play the game soundtrack
    func playBackgroundMusic(){
        let soundFilePath = Bundle.main.path(forResource: "Soundtrack", ofType: "mp3")
        let soundFileURL = URL(fileURLWithPath: soundFilePath!)
        do{
            let player = try AVAudioPlayer(contentsOf: soundFileURL)
            soundtrack = player
            player.volume = 0.6
            player.numberOfLoops = -1 //Infinite Loop 
            player.play()
        } catch {
            print("\(error)")
        }
    }
    
}

let gameViewController = GameViewController()
PlaygroundPage.current.liveView = gameViewController.view



