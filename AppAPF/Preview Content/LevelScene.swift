import SwiftUI
import SpriteKit
import AVFoundation

class LevelScene: SKScene {
    var levelCompleteCallback: (() -> Void)?
    @State private var audioPlayer: AVAudioPlayer?
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    var car2: SKSpriteNode?
    var car3: SKSpriteNode?
    var infoButton: SKSpriteNode?
    var info: SKSpriteNode!
    var currentSequenceLevel: [String] = []
    var correctSequenceLevel1: [String] = ["bumblebee", "car3", "car2", "car1"]
    var correctSequenceLevel2: [String] = ["car1", "car2", "car3", "bumbleBee"]
    var indexCorrectSequence: Int = 0
    var isTouched: [Int] = [0, 0, 0, 0]
    var infoButtonIsTouched: Bool = false
    
    override func didMove(to view: SKView) {
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [])
            try? AVAudioSession.sharedInstance().setActive(true)
        // Inizializza gli sprite con il nome definito nell'editor di SpriteKit
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        infoButton = childNode(withName: "infoButton") as? SKSpriteNode
        info = childNode(withName: "info") as? SKSpriteNode
        info.alpha = 0
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
        car2 = childNode(withName: "car2") as? SKSpriteNode
        car3 = childNode(withName: "car3") as? SKSpriteNode
        
        startAnimation {
            self.indexCorrectSequence = 0
        }
    
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        infoButton?.alpha = 1.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node == infoButton {
            // Se infoButton non è stato toccato prima, mostra l'info
            if !infoButtonIsTouched {
                infoButton?.alpha = 1.0
                info.run(SKAction.fadeIn(withDuration: 0.3))
                infoButtonIsTouched = true  // Imposta il flag a true
            } else {
                // Se infoButton è stato già toccato, nascondi l'info
                info.run(SKAction.fadeOut(withDuration: 0.3))
                infoButton?.alpha = 1.0  // Rendi visibile di nuovo il bottone
                infoButtonIsTouched = false  // Imposta il flag a false
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
            
            // Tocca Bumblebee
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
            // Tocca Car1
            if node == car1 {
                if correctSequenceLevel1[indexCorrectSequence] == "car1" {
                    print("🚗 Car1 is moving...")
                    if isTouched[1] == 0 {
                        moveCar1 {
                            self.indexCorrectSequence += 1
                            self.showLevelCompleteLabel() // Mostra il messaggio "Level Complete!"

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
                    }
                    
                } else {
                    print("⛔ It's not Car3's turn yet!")
                    playClacson()
                }
        }
    }
    
    // Ripristina la posizione delle macchine
    func startAnimation(completion: @escaping () -> Void) {
        
            bumblebee?.position = CGPoint(x: 81, y: -1500) //y:-440 Posizione iniziale di Bumblebee
            car1?.position = CGPoint(x: 800, y: 80) //x:320 Posizione iniziale di Car1
            car2?.position = CGPoint(x: -80, y: 1500)//y:391
            car3?.position = CGPoint(x: -800, y: -69)//x:265
            
            guard let bumblebee = bumblebee else { return }
            let moveAction = SKAction.moveBy(x: 0, y: 1060, duration: 2.0)
            moveAction.timingMode = .easeInEaseOut
            bumblebee.run(moveAction, completion: completion)
            
            guard let car1 = car1 else { return }
            let moveActionCar1 = SKAction.moveBy(x: -480, y: 0, duration: 2.0)
            moveActionCar1.timingMode = .easeInEaseOut
            car1.run(moveActionCar1)
            
            guard let car2 = car2 else { return }
            let moveActionCar2 = SKAction.moveBy(x: 0, y: -1109, duration: 2.0)
            moveActionCar2.timingMode = .easeInEaseOut
            car2.run(moveActionCar2)
            
            guard let car3 = car3 else { return }
            let moveActionCar3 = SKAction.moveBy(x: 535, y: 0, duration: 2.0)
            moveActionCar3.timingMode = .easeInEaseOut
            car3.run(moveActionCar3)
    }
    
    // Muove Car1 orizzontalmente
    func moveCar1(completion: @escaping () -> Void) {
        
            guard let car1 = car1 else { return }
            let moveAction = SKAction.moveBy(x: -1200, y: 0, duration: 2.0)
            moveAction.timingMode = .easeInEaseOut
            car1.run(moveAction, completion: completion)
    }
    
    func moveCar2(completion: @escaping () -> Void) {
    
            guard let car2 = car2 else { return }
            
            let moveForward = SKAction.moveBy(x: 0, y: -2500, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward])
            car2.run(sequence, completion: completion)
        
    }
    
    func moveCar3(completion: @escaping () -> Void) {
        
            guard let car3 = car3 else { return }
            
            let moveForward = SKAction.moveBy(x: 200, y: 0, duration: 1.5)
            let rotateRight = SKAction.rotate(toAngle: -180.0 * CGFloat.pi / 180.0, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 0, y: -2500, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            car3.run(sequence, completion: completion)
        
    }
    
    // Muove Bumblebee con una curva a destra
    func moveBumblebee(completion: @escaping () -> Void) {
        
            guard let bumblebee = bumblebee else { return }
            
            let moveForward = SKAction.moveBy(x: 0, y: 350, duration: 1.5)
            let rotateRight = SKAction.rotate(toAngle: -.pi / 2, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 750, y: 0, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            bumblebee.run(sequence, completion: completion)
    }
    
    func showLevelCompleteLabel() {
        playLevelComplete()
        // Crea il messaggio di completamento
        let label = SKLabelNode(text: "LEVEL COMPLETE!")
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 80
        label.fontColor = .yellow
        label.position = CGPoint(x: 0, y: 0)
        label.zPosition = 150
        label.alpha = 0  // Inizialmente invisibile
        
        // Aggiunge un bordo nero per migliorare la leggibilità
        let shadowLabel = SKLabelNode(text: "LEVEL COMPLETE!")
        shadowLabel.fontName = "AvenirNext-Bold"
        shadowLabel.fontSize = 80
        shadowLabel.fontColor = .black
        shadowLabel.position = CGPoint(x: 3, y: -3)  // Leggero offset per effetto ombra
        shadowLabel.zPosition = label.zPosition - 1
        label.addChild(shadowLabel)
        
        // Crea uno sfondo trasparente dietro il testo
        let background = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.7), size: CGSize(width: size.width * 0.8, height: 150))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = label.zPosition - 1
        background.alpha = 0  // Inizialmente invisibile
        
        addChild(background)
        addChild(label)
        
        // Animazioni
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
        let wait = SKAction.wait(forDuration: 2.0)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        
        // Sequenza di animazioni per il testo
        let textAnimation = SKAction.sequence([fadeIn, scaleUp, scaleDown, wait, fadeOut, remove])
        
        // Sequenza di animazioni per lo sfondo
        let backgroundAnimation = SKAction.sequence([fadeIn, wait, fadeOut, remove])
        levelCompleteCallback?()

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
