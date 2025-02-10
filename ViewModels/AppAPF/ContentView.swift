import SwiftUI
import SpriteKit

//prova

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    func loadErrorScene() -> SKScene {
        guard let scene = SKScene(fileNamed: "ErrorScene") else {
            fatalError("Impossibile caricare la scena ErrorScene")
        }
        //scene.size = CGSize(width: 750, height: 1344)
        scene.scaleMode = .aspectFit
        return scene
    }

    func loadSettingsScene() -> SKScene {
        guard let scene = SKScene(fileNamed: "SettingsScene") else {
            fatalError("Impossibile caricare la scena SettingsScene")
        }
        //scene.size = CGSize(width: 750, height: 1344)
        scene.scaleMode = .aspectFit
        return scene
    }
    // Carica la scena HomeScene
    func loadHomeScene() -> SKScene {
        guard let scene = SKScene(fileNamed: "HomeScene") else {
            fatalError("Impossibile caricare la scena HomeScene")
        }
        //scene.size = CGSize(width: 750, height: 1344)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Tab HomeScene
            VStack {
                SpriteView(scene: loadHomeScene())
                    .frame(width: 750, height: 1344)
                
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // Tab Placeholder (Impostazioni o altra schermata)
            VStack {
                SpriteView(scene: loadErrorScene())
                    .frame(width: 750, height: 1344)
            }
            .tabItem {
                Label("Errors", systemImage: "x.circle")
            }
            .tag(1)
            
            VStack {
                SpriteView(scene: loadSettingsScene())
                    .frame(width: 750, height: 1344)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
