//
//  ContentView.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 07/02/25.
//


//aiuto non riesco a fare un button per far aprire QuizView dalla home :\
//per ora l ho messo su TabView

//da fixare(dopo averlo testato sul cellulare):
//della TabView spunta solo la home e per accedere alle altre sezioni bisogna cliccare nella loro posizione anche se non c è l icona, una volta cliccato spuntano tutte le icone della tb view
//gli errori vengono salvati, per visualizzarli bisogna chiudere e riaprire l'app :(

//la tab quiz per testarla vai nella sua view perchè qui crasha dato che non ho specificato nulla

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var errorManager = ErrorManager()
    
    @State private var selectedTab = 0
    

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
            ZStack {
                    SpriteView(scene: loadHomeScene())
                        .edgesIgnoringSafeArea(.all)
                    
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // Tab ErrorScene
                ErrorsView()
                    .tabItem{
                        Label("Errors", systemImage: "x.circle")
                    }
                    .tag(1)
                    .environmentObject(errorManager)
            
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
