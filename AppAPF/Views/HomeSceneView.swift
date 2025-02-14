import SwiftUI
import SpriteKit

struct HomeSceneView: View {
    @Binding var isInLevelScene: Bool  // Control for switching to the LevelScene
    @State private var isVisible: Bool = false  // State to control fade-in animation

    var scene: HomeScene {
        let scene = HomeScene(fileNamed: "HomeScene")!  // Load the HomeScene from the file
        scene.scaleMode = .aspectFill  // Set the scale mode for the scene
        scene.onCarButtonTapped = {
            withAnimation(.easeInOut(duration: 0.5)) {
                isInLevelScene = true  // Change to LevelScene on button tap with animation
            }
        }
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)  // Display the SpriteKit scene
            .ignoresSafeArea()  // Ignore safe area to make the scene fill the screen
            .opacity(isVisible ? 1 : 0)  // Initial opacity 0, will become 1 after fade-in
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isVisible = true  // Trigger the fade-in animation when the view appears
                }
            }
    }
}
