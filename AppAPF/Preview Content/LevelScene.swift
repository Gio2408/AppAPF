import SwiftUI
import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    var car2: SKSpriteNode?
    var car3: SKSpriteNode?
    var infoButton: SKSpriteNode?
    var info: SKSpriteNode!
    var numberLevel: Int = 1 // Inizia dal livello 1
    var currentSequenceLevel: [String] = []
    var correctSequenceLevel1: [String] = ["bumblebee", "car3", "car2", "car1"]
    var correctSequenceLevel2: [String] = ["car1", "car2", "car3", "bumbleBee"]
    var indexCorrectSequence: Int = 0
    var isTouched: [Int] = [0, 0, 0, 0]
    
    override func didMove(to view: SKView) {
        // Inizializza gli sprite con il nome definito nell'editor di SpriteKit
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        infoButton = childNode(withName: "infoButton") as? SKSpriteNode
        info = childNode(withName: "info") as? SKSpriteNode
        info.alpha = 0
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
        car2 = childNode(withName: "car2") as? SKSpriteNode
        car3 = childNode(withName: "car3") as? SKSpriteNode
        
        setupLevel()
    }
    
    
    func setupLevel() {
        // Inizializza la sequenza corretta per il livello attuale
        updateSequence()
        
        // Ripristina le posizioni delle macchine
        resetCarsPosition(){
            self.indexCorrectSequence = 0
        }
        
        // Imposta le animazioni iniziali o altre logiche di setup per il livello
        // Ad esempio, potresti voler animare l'incrocio o eseguire altre configurazioni visive
        print("🔧 Level \(numberLevel) setup completed!")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        infoButton?.alpha = 1.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        _ = atPoint(location)
        
        infoButton?.alpha = 1.0
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node == infoButton {
                infoButton?.alpha = 0.5
                
                if let info = info {
                    let fadeIn = SKAction.fadeIn(withDuration: 0.3)
                    let fadeOut = SKAction.fadeOut(withDuration: 0.3)
                    let delay = SKAction.wait(forDuration: 5.0) // L'immagine rimane visibile per 3 secondi
                    let sequence = SKAction.sequence([fadeIn, delay, fadeOut])
                    info.run(sequence)
                }
            }
        
        switch numberLevel {
        case 1:
            if indexCorrectSequence >= correctSequenceLevel1.count {
                print("✅ Level \(numberLevel) completed!")
                
                nextLevel()
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
                }
            }
            // Tocca Car1
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
                }
            }
            
        case 2:
            print("Nothing")
        default:
            print("Nothing")
        }
        
    }
    
    // Passa al livello successivo
    func nextLevel() {
        numberLevel += 1
        self.isTouched[0] = 0
        self.isTouched[1] = 0
        self.isTouched[2] = 0
        self.isTouched[3] = 0
        resetCarsPosition(){
            self.indexCorrectSequence = 0
        }
        // Cambia l'immagine di sfondo
        changeBackground()
        
        // Ripristina le posizioni delle macchine
       
        
        // Aggiorna la sequenza corretta in base al livello
        updateSequence()
    }
    
    // Cambia l'immagine di sfondo in base al livello
    func changeBackground() {
        guard let incrocioCroce = incrocioCroce else { return }
        let textureName = "incrocioCroce_\(numberLevel)" // Usa immagini diverse per i livelli
        let newTexture = SKTexture(imageNamed: textureName)
        incrocioCroce.texture = newTexture
    }
    
    // Ripristina la posizione delle macchine
    func resetCarsPosition(completion: @escaping () -> Void) {
        switch numberLevel {
        case 1:
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
        default:
            bumblebee?.position = CGPoint(x: 0, y: 0)
            car1?.position = CGPoint(x: 0, y: 0)
        }
        
    }
    
    // Aggiorna la sequenza corretta di "go" e "wait" per ogni livello
    func updateSequence() {
        switch numberLevel {
        case 1:
            currentSequenceLevel = correctSequenceLevel1
        default:
            currentSequenceLevel = correctSequenceLevel1
        }
    }
    
    // Muove Car1 orizzontalmente
    func moveCar1(completion: @escaping () -> Void) {
        switch numberLevel {
        case 1:
            guard let car1 = car1 else { return }
            let moveAction = SKAction.moveBy(x: -1200, y: 0, duration: 2.0)
            moveAction.timingMode = .easeInEaseOut
            car1.run(moveAction, completion: completion)
        default:
            break
        }
        
    }
    
    func moveCar2(completion: @escaping () -> Void) {
        switch numberLevel {
        case 1:
            guard let car2 = car2 else { return }
            
            let moveForward = SKAction.moveBy(x: 0, y: -2500, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward])
            car2.run(sequence, completion: completion)
            
        default:
            break
        }
    }
    
    func moveCar3(completion: @escaping () -> Void) {
        switch numberLevel {
        case 1:
            guard let car3 = car3 else { return }
            
            let moveForward = SKAction.moveBy(x: 200, y: 0, duration: 1.5)
            let rotateRight = SKAction.rotate(toAngle: -180.0 * CGFloat.pi / 180.0, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 0, y: -2500, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            car3.run(sequence, completion: completion)
        default:
            break
        }
    }
    
    // Muove Bumblebee con una curva a destra
    func moveBumblebee(completion: @escaping () -> Void) {
        
        switch numberLevel {
        case 1:
            guard let bumblebee = bumblebee else { return }
            
            let moveForward = SKAction.moveBy(x: 0, y: 350, duration: 1.5)
            let rotateRight = SKAction.rotate(toAngle: -.pi / 2, duration: 0.3, shortestUnitArc: true)
            let moveRight = SKAction.moveBy(x: 750, y: 0, duration: 1.5)
            
            moveForward.timingMode = .easeInEaseOut
            moveRight.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([moveForward, rotateRight, moveRight])
            bumblebee.run(sequence, completion: completion)
        default:
            break
        }
    }
}
