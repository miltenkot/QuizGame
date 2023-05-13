//
//  NavigationState.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

class NavigationState: ObservableObject {
    @Published var routes: [Routes] = []
}
