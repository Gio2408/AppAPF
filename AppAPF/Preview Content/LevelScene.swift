import SwiftUI
import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    
    var numberLevel: Int = 1 // Inizia dal livello 1
    var correctSequence: [String] = ["wait", "go"] // Sequenza iniziale
    var indexCorrectSequence: Int = 0
    var isTouched: Bool = false
    
    override func didMove(to view: SKView) {
        // Inizializza gli sprite con il nome definito nell'editor di SpriteKit
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
        
        setupLevel()
    }
    
    
    func setupLevel() {
        // Inizializza la sequenza corretta per il livello attuale
        updateSequence()
        
        // Ripristina le posizioni delle macchine
        resetCarsPosition()
        
        // Imposta le animazioni iniziali o altre logiche di setup per il livello
        // Ad esempio, potresti voler animare l'incrocio o eseguire altre configurazioni visive
        print("🔧 Level \(numberLevel) setup completed!")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        // Resetta la sequenza se completata
        if indexCorrectSequence >= correctSequence.count {
            print("✅ Level \(numberLevel) completed!")
            nextLevel()
            return
        }

        // Tocca Car1
        if node == car1 {
            if correctSequence[indexCorrectSequence] == "wait" {
                print("🚗 Car1 is moving...")
                moveCar1 {
                    self.indexCorrectSequence += 1
                }
            } else {
                print("⛔ It's not Car1's turn yet!")
            }
        }
        
        // Tocca Bumblebee
        if node == bumblebee{
            if correctSequence[indexCorrectSequence] == "go" {
                print("🚙 Bumblebee is moving...")
                if !isTouched {
                    moveBumblebee {
                        self.indexCorrectSequence += 1
                    }
                    self.isTouched = true
                }
                
            } else {
                print("⛔ It's not Bumblebee's turn yet!")
            }
        }
    }
    
    // Passa al livello successivo
    func nextLevel() {
        numberLevel += 1
        indexCorrectSequence = 0
        
        // Cambia l'immagine di sfondo
        changeBackground()
        
        // Ripristina le posizioni delle macchine
        resetCarsPosition()
        
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
    func resetCarsPosition() {
        switch numberLevel {
        case 1:
            bumblebee?.position = CGPoint(x: 81, y: -400) // Posizione iniziale di Bumblebee
            car1?.position = CGPoint(x: 320, y: 80) // Posizione iniziale di Car1
        
        default:
            bumblebee?.position = CGPoint(x: 0, y: 0)
            car1?.position = CGPoint(x: 0, y: 0)
        }
        
    }
    
    // Aggiorna la sequenza corretta di "go" e "wait" per ogni livello
    func updateSequence() {
        switch numberLevel {
        case 2:
            correctSequence = ["go", "wait", "go"]
        case 3:
            correctSequence = ["wait", "go", "go"]
        default:
            correctSequence = ["wait", "go"] // Torna alla sequenza base
        }
    }
    
    // Muove Car1 orizzontalmente
    func moveCar1(completion: @escaping () -> Void) {
        guard let car1 = car1 else { return }
        let moveAction = SKAction.moveBy(x: -1200, y: 0, duration: 2.0)
        moveAction.timingMode = .easeInEaseOut
        car1.run(moveAction, completion: completion)
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
}
