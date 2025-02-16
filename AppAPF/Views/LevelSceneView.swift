import SwiftUI
import SpriteKit
import AVFoundation

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // Stato per tornare alla HomeView
    @State private var showExitConfirmation = false  // Stato per mostrare il popup
    @State private var audioPlayer: AVAudioPlayer?  // Per la gestione dell'audio
    
    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Error: Unable to load LevelScene.sks")
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        ZStack {
            if let scene = scene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            } else {
                Text("Error loading the scene")
                    .foregroundColor(.red)
            }

            VStack {
                HStack {
                    Button(action: {
                        showExitConfirmation = true  // Mostra il popup di conferma
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()
            }
        }
        .transition(.opacity)
        .alert("Are you sure you want to exit?", isPresented: $showExitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Exit", role: .destructive) {
                stopSound()  // Ferma il suono quando esci dalla scena
                isInLevelScene = false  // Torna alla HomeView
            }
        }
        .onAppear {
            playSound()  // Avvia il suono quando entra in LevelScene
        }
        .onDisappear {
            stopSound()  // Ferma il suono quando esce dalla LevelScene
        }
    }

    // Funzione per riprodurre il suono
    func playSound() {
        guard let url = Bundle.main.url(forResource: "car-engine", withExtension: "mp3") else {
            print("Errore: File audio non trovato")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Errore nella riproduzione del suono: \(error.localizedDescription)")
        }
    }

    // Funzione per fermare il suono
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(isInLevelScene: .constant(true))
    }
}
