import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var errorManager = ErrorManager()
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            // Mostra la vista attuale in base alla selezione
            Group {
                switch selectedTab {
                case 0: HomeSceneView()
                case 1: ErrorsView().environmentObject(errorManager)
                case 2: SettingsView()
                default: HomeSceneView()
                }
            }
            .transition(.opacity)
            .ignoresSafeArea()
            
            // Barra in stile SpriteKit sovrapposta in basso
            VStack {
                Spacer()
                HStack {
                    CustomTabButton(icon: "house.fill", tag: 0, selectedTab: $selectedTab)
                    CustomTabButton(icon: "x.circle", tag: 1, selectedTab: $selectedTab)
                    CustomTabButton(icon: "gearshape.fill", tag: 2, selectedTab: $selectedTab)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .shadow(radius: 5)
            }
        }
    }
}

// Pulsante personalizzato per la tab bar in stile SpriteKit
struct CustomTabButton: View {
    var icon: String
    var tag: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = tag
            }
        }) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(selectedTab == tag ? .blue : .gray)
                .padding(10)
                .background(selectedTab == tag ? Color.blue.opacity(0.2) : Color.clear)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ContentView()
}
