import SwiftUI
import SpriteKit

struct HomeSceneView: View {
    @Binding var levelScene: Int  // Control for switching to the LevelScene
    @State private var isVisible: Bool = false  // State to control fade-in animation

    var scene: HomeScene {
        let scene = HomeScene(fileNamed: "HomeScene")!
        scene.scaleMode = .aspectFill
        scene.onCarButtonTapped = {
            withAnimation(.easeInOut(duration: 0.3)) {
                levelScene = 1  // Change to LevelScene on button tap with animation
            }
        }
        return scene
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .opacity(isVisible ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible = true
                    }
                }
            Text("Choose Challenge")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding([.top], 8)
                .padding([.leading, .trailing], 17)
            
            /*Text("PALERMO")
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding([.top], 368)
                .padding(.leading, 317)*/
        }
    }
}

struct HomeSceneView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSceneView(levelScene: .constant(0))
    }
}
