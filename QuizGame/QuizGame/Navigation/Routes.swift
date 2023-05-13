//
//  Routes.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import Foundation

enum Routes: Hashable {
    case mainNavigation(QuizRoutes)
    
    enum QuizRoutes: Hashable {
        case question([Question], Int)
        case results(correctAnswers: Int, numberOfQuestions: Int)
    }
}
