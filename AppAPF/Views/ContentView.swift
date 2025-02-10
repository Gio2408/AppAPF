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

//prova

struct ContentView: View {
    
    @StateObject var errorManager = ErrorManager()
    @State private var selectedTab = 0
    @State private var isQuizViewActive = false
    
    /*func loadErrorScene() -> SKScene {
        guard let scene = SKScene(fileNamed: "ErrorScene") else {
            fatalError("Impossibile caricare la scena ErrorScene")
        }
        //scene.size = CGSize(width: 750, height: 1344)
        scene.scaleMode = .aspectFit
        return scene
    }*/

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
    
    //test
    func presentQuizView(from viewController: UIViewController) {
        let quizView = QuizView()
        let hostingController = UIHostingController(rootView: quizView)
        
        viewController.present(hostingController, animated: true)
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
            
            QuizView()
                    .tabItem {
                        Label("Quiz", systemImage: "questionmark.circle.fill")
                    }
                    .tag(2)
            
            // Tab Placeholder (Impostazioni o altra schermata)
            ErrorsView()
                .tabItem {
                    Label("Errors", systemImage: "x.circle")
                }
                .tag(1)
                .environmentObject(errorManager)
            
            
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
