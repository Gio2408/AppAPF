/*import SwiftUI

struct CustomTabButton: View {
    // Icon name for the button (SF Symbols)
    let icon: String
    
    // Identifier for the button's tab
    let tag: Int
    
    // Binding to track the currently selected tab
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            // Update the selected tab when the button is tapped
            selectedTab = tag
        }) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundColor(selectedTab == tag ? .blue : .gray)
        }
    }
}*/
