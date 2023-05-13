//
//  QuizGameApp.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

@main
struct QuizGameApp: App {
    @StateObject private var navigationState = NavigationState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routes) {
                IndroductionView()
                    .navigationDestination(for: Routes.self) { route in
                        switch route {
                        case .mainNavigation(let routes):
                            MainRouter(routes: routes).configure()
                        }
                    }
            }
            .environmentObject(navigationState)
        }
    }
}
