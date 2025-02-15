//
//  QuizManager.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 15/02/25.
//

import SwiftUI

class QuizManager: ObservableObject {
    @Published var currentPhaseIndex: Int = 0  // Current quiz phase index.
}
