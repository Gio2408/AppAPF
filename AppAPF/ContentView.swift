import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    func loadErrorScene() -> SKScene {
        let scene = SKScene(fileNamed: "ErrorScene")
        //scene.size = CGSize(width: 750, height: 1344)
        scene?.scaleMode = .aspectFill
        return scene!
    }

    func loadSettingsScene() -> SKScene {
        let scene = SKScene(fileNamed: "SettingsScene")
        //scene.size = CGSize(width: 750, height: 1344)
        scene?.scaleMode = .aspectFill
        return scene!
    }
    // Carica la scena HomeScene
    func loadHomeScene() -> SKScene {
        let scene = SKScene(fileNamed: "HomeScene")
        //scene.size = CGSize(width: 750, height: 1344)
        scene?.scaleMode = .aspectFill
        return scene!
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Tab HomeScene
            VStack {
                    SpriteView(scene: loadHomeScene())
                    .edgesIgnoringSafeArea(.all)
                    
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // Tab ErrorScene
            VStack {
                SpriteView(scene: loadErrorScene())
                    .edgesIgnoringSafeArea(.all)
            }
            .tabItem {
                Label("Errors", systemImage: "x.circle")
            }
            .tag(1)
            
            //Tab SettingsScene
            
            VStack {
                SpriteView(scene: loadSettingsScene())
                    .edgesIgnoringSafeArea(.all)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
