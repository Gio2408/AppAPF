import SwiftUI
import SpriteKit
import AVFoundation

class Level2Scene: SKScene {
    var level2CompleteCallback: (() -> Void)?
    @State private var audioPlayer: AVAudioPlayer?
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    var car2: SKSpriteNode?
    var car3: SKSpriteNode?
    var infoButton: SKSpriteNode?
    var info: SKSpriteNode!
    var currentSequenceLevel: [String] = []
    var correctSequenceLevel1: [String] = ["bumblebee", "car1", "car2", "car3"]
    var indexCorrectSequence: Int = 0
    var isTouched: [Int] = [0, 0, 0, 0]
    var infoButtonIsTouched: Bool = false
    
    override func didMove(to view: SKView) {
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [])
        try? AVAudioSession.sharedInstance().setActive(true)
        // Initialize sprites with the name defined in the SpriteKit editor
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        infoButton = childNode(withName: "infoButton") as? SKSpriteNode
        info = childNode(withName: "info") as? SKSpriteNode
        info.alpha = 0
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
        car2 = childNode(withName: "car2") as? SKSpriteNode
        car3 = childNode(withName: "car3") as? SKSpriteNode
        
        /*startAnimation {
            self.indexCorrectSequence = 0
        }*/
    
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        infoButton?.alpha = 1.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node == infoButton {
            // If infoButton has not been touched before, show the info
            if !infoButtonIsTouched {
                infoButton?.alpha = 1.0
                info.run(SKAction.fadeIn(withDuration: 0.3))
                infoButtonIsTouched = true // Set the flag to true
            } else {
                // If infoButton has already been touched, hide the info
                info.run(SKAction.fadeOut(withDuration: 0.3))
                infoButton?.alpha = 1.0 // Make the button visible again
                infoButtonIsTouched = false // Set the flag to false
            }
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node == infoButton {
            infoButton?.alpha = 0.5
        }
        
        if indexCorrectSequence >= correctSequenceLevel1.count {
            print("✅ Level 1 completed!")
            return
        }
        
        // Touch Bumblebee
        if node == bumblebee{
            if correctSequenceLevel1[indexCorrectSequence] == "bumblebee" {
                print("🚙 Bumblebee is moving...")
                if isTouched[0] == 0{
                    moveBumblebee {
                        self.indexCorrectSequence += 1
                    }
                    self.isTouched[0] = 1
                }
                
            } else {
                print("⛔ It's not Bumblebee's turn yet!")
                playClacson()
            }
        }
        // Touch Car1
        if node == car1 {
            if correctSequenceLevel1[indexCorrectSequence] == "car1" {
                print("🚗 Car1 is moving...")
                if isTouched[1] == 0 {
                    moveCar1 {
                        self.indexCorrectSequence += 1
                    }
                    self.isTouched[1] = 1
                }
            } else {
                print("⛔ It's not Car1's turn yet!")
                playClacson()
            }
        }
        
        if node == car2 {
            if correctSequenceLevel1[indexCorrectSequence] == "car2" {
                print("🚗 Car2 is moving...")
                if isTouched[2] == 0 {
                    moveCar2 {
                        self.indexCorrectSequence += 1
                    }
                    self.isTouched[2] = 1
                }
            } else {
                print("⛔ It's not Car2's turn yet!")
                playClacson()
            }
        }
        
        if node == car3 {
            if correctSequenceLevel1[indexCorrectSequence] == "car3" {
                print("🚗 Car3 is moving...")
                if isTouched[3] == 0 {
                    moveCar3 {
                        self.indexCorrectSequence += 1
                    }
                    self.isTouched[3] = 1
                    self.showLevelCompleteLabel() // Show the "Level Complete!" message
                }
                
            } else {
                print("⛔ It's not Car3's turn yet!")
                playClacson()
            }
        }
    }

    func moveCar1(completion: @escaping () -> Void) {
        
        guard let car1 = car1 else { return }
        let moveAction = SKAction.moveBy(x: 1000, y: 1000, duration: 2.0)
        moveAction.timingMode = .easeInEaseOut
        car1.run(moveAction, completion: completion)
    }
    
    func moveCar2(completion: @escaping () -> Void) {
        guard let car2 = car2 else { return }
        
        let moveForward = SKAction.moveBy(x: 1150, y: -1150, duration: 1.5)
        
        moveForward.timingMode = .easeInEaseOut
        
        let sequence = SKAction.sequence([moveForward])
        car2.run(sequence, completion: completion)
    
    }
    
    func moveCar3(completion: @escaping () -> Void) {
            
            guard let car3 = car3 else { return }
            
            let moveForward = SKAction.moveBy(x: -300, y: -300, duration: 1.5)
        let rotateRight = SKAction.rotate(toAngle: -180.0 * CGFloat.pi / 250.00, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 1000, y: -1000, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            car3.run(sequence, completion: completion)
        
        }
        
        // Moves Bumblebee with a right curve
        func moveBumblebee(completion: @escaping () -> Void) {
            
            guard let bumblebee = bumblebee else { return }
            
            let moveForward = SKAction.moveBy(x: -220, y: 220, duration: 1.5)
            let rotateRight = SKAction.rotate(toAngle: -.pi / 4, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 650, y: 650, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            bumblebee.run(sequence, completion: completion)
        }
        
        func showLevelCompleteLabel() {
            playLevelComplete()
            // Create the completion message
            let label = SKLabelNode(text: "LEVEL COMPLETE!")
            label.fontName = "AvenirNext-Bold"
            label.fontSize = 80
            label.fontColor = .white
            label.position = CGPoint(x: 0, y: 0)
            label.zPosition = 150
            label.alpha = 0 // Initially invisible
            
            // Add a black border to improve readability
            let shadowLabel = SKLabelNode(text: "LEVEL COMPLETE!")
            shadowLabel.fontName = "AvenirNext-Bold"
            shadowLabel.fontSize = 80
            shadowLabel.fontColor = .black
            shadowLabel.position = CGPoint(x: 3, y: -3) // Slight offset for shadow effect
            shadowLabel.zPosition = label.zPosition - 1
            label.addChild(shadowLabel)
            
            // Create a transparent background behind the text
            let background = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.7), size: CGSize(width: size.width * 0.8, height: 150))
            background.position = CGPoint(x: size.width / 2, y: size.height / 2)
            background.zPosition = label.zPosition - 1
            background.alpha = 0 // Initially invisible
            
            addChild(background)
            addChild(label)
            
            // Animations
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
            let wait = SKAction.wait(forDuration: 2.0)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let remove = SKAction.removeFromParent()
            
            // Animation sequence for the text
            let textAnimation = SKAction.sequence([fadeIn, scaleUp, scaleDown, wait, fadeOut, remove])
            
            // Animation sequence for the background
            let backgroundAnimation = SKAction.sequence([fadeIn, wait, fadeOut, remove])
            
            level2CompleteCallback?()

            label.run(textAnimation)
            background.run(backgroundAnimation)

        }
        
        func playLevelComplete() {
            let soundAction = SKAction.playSoundFileNamed("levelComplete.mp3", waitForCompletion: false)
            self.run(soundAction)
        }

        func playClacson() {
            let soundAction = SKAction.playSoundFileNamed("clacson.mp3", waitForCompletion: false)
            self.run(soundAction)
        }
    }
