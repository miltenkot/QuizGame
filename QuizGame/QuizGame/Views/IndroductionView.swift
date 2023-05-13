//
//  IndroductionView.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

struct IndroductionView: View {
    @AppStorage("correctAnswers") var correctAnswers: Int = 0
    @EnvironmentObject private var navigationState: NavigationState
    @State private var quiz: Quiz = .empty
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(quiz.title)
                    .font(.primaryTitle)
                Text("\(quiz.questions.count) questions")
                    .font(.primaryContent)
                Button("Start") {
                    navigationState.routes.append(
                        .mainNavigation(.question(quiz.questions, 0))
                    )
                }
                .buttonStyle(CustomButtonStyle())
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            do {
                let jsonData = questionMock.data(using: .utf8)!
                let decodedQuiz = try JSONDecoder().decode(Quiz.self, from: jsonData)
                quiz = decodedQuiz
            } catch {
                print(error)
            }
        }
        .onAppear {
            correctAnswers = 0
        }
    }
}

struct IndroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IndroductionView()
    }
}
