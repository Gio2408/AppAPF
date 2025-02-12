import SwiftUI
import SpriteKit

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // Stato per tornare indietro

    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Errore: Impossibile caricare LevelScene.sks")
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if let scene = scene {
                    SpriteView(scene: scene)
                        .ignoresSafeArea()
                } else {
                    Text("Errore nel caricamento della scena")
                        .foregroundColor(.red)
                }

                VStack {
                    HStack {
                        // Aggiungi un NavigationLink che porta a ContentView
                        NavigationLink(destination: ContentView()
                            .navigationBarBackButtonHidden()) {
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
            .navigationBarBackButtonHidden(true) // Nascondiamo il back button di default
            .navigationBarHidden(true) // Nascondiamo la barra di navigazione
            .transition(.move(edge: .leading)) // Impostiamo la transizione da sinistra
        }
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(isInLevelScene: .constant(true))
    }
}
