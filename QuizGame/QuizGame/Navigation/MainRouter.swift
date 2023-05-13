//
//  MainRouter.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

struct MainRouter {
    let routes: Routes.QuizRoutes
    
    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .question(let questions, let questionNumber):
            QuestionView(questions: questions, questionNumber: questionNumber)
        case .results(let correctAnswers, let numberOfQuestions):
            ResultsView(correctAnswers: correctAnswers, numberOfQuestions: numberOfQuestions)
        }
    }
}
