//
//  ScoreView.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 12/02/25.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    
    @EnvironmentObject var scoreManager: ScoreManager

    var body: some View {
        NavigationView{
            ScrollView {
                    VStack {
                        Text("\(scoreManager.score)")
                    }
                .navigationTitle(Text("Score"))
            }
        }
    }
}


//esempio di view

#Preview {
    ScoreView()
}
