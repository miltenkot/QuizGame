//
//  QuestionView.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

enum AnswerType {
    case unvoted
    case correct
    case bad
}

struct QuestionView: View {
    @EnvironmentObject private var navigationState: NavigationState
    @AppStorage("circleProgress") var circleProgress: [Int: Bool] = [:]
    @AppStorage("correctAnswers") var correctAnswers: Int = 0
    @State private var timerValue : Float = 1500
    @State private var deadlineTimer: Timer? = nil
    @State private var selectedOption: String = ""
    @State private var selectedAnswer: AnswerType = .unvoted
    let questions: [Question]
    let questionNumber: Int
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            VStack {
                Text(questions[questionNumber].question)
                    .font(.primaryTitle)
                ProgressView("", value: timerValue, total: 1500)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .padding()
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .shadow(radius: 10)
                    .onAppear {
                        deadlineTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                            withAnimation {
                                self.timerValue -= 1
                            }
                        }
                    }
                
                VStack {
                    if questions[questionNumber].options.count == 4 {
                        HStack {
                            optionButton(questions[questionNumber].options[0])
                            optionButton(questions[questionNumber].options[1])
                        }
                        HStack {
                            optionButton(questions[questionNumber].options[2])
                            optionButton(questions[questionNumber].options[3])
                        }
                    }
                }
                HStack {
                    ForEach(0..<questions.count, id: \.self) { question in
                        if question == questionNumber {
                            if timerValue > 0 {
                                CircleIndicator(answear: $selectedAnswer)
                            } else {
                                CircleIndicator(answear: .constant(.bad))
                            }
                        } else if questionNumber > question {
                            if circleProgress[question]! {
                                CircleIndicator(answear: .constant(.correct))
                            } else {
                                CircleIndicator(answear: .constant(.bad))
                            }
                        } else {
                            CircleIndicator(answear: .constant(.unvoted))
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
            .toolbar(.hidden)
            .onChange(of: timerValue) { newValue in
                if timerValue <= 0 {
                    nextQuestion {
                        selectedOption = questions[questionNumber].answer
                        selectedAnswer = .correct
                    }
                }
            }
        }
    }
    
    @MainActor
    private func optionButton(_ option: String) -> some View {
        Button {
            nextQuestion {
                selectedOption = option
                selectedAnswer = selectedOption == questions[questionNumber].answer ? .correct : .bad
                if selectedAnswer == .correct {
                    correctAnswers += 1
                    circleProgress[questionNumber] = true
                } else {
                    circleProgress[questionNumber] = false
                }
            }
        } label: {
            Text(option)
                .frame(width: 150, height: 50)
                .minimumScaleFactor(0.5)
        }
        .padding(8)
        .disabled(!selectedOption.isEmpty)
        .ifElse(selectedOption == option) { view in
            view.buttonStyle(CustomButtonStyle(cornerRadius: 8,
                                               answerType: selectedAnswer))
        } elseTransform: { view in
            view
                .ifElse(option == questions[questionNumber].answer && selectedAnswer != .unvoted) { view in
                    view
                        .buttonStyle(CustomButtonStyle(cornerRadius: 8,
                                                       answerType: .correct))
                } elseTransform: { view in
                    view
                        .buttonStyle(CustomButtonStyle(cornerRadius: 8))
                }
        }
        
    }
    
    private func nextQuestion(action: @escaping () -> Void) {
        Task {
            deadlineTimer?.invalidate()
            deadlineTimer = nil
            action()
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            if questionNumber < questions.count - 1 {
                navigationState.routes.append(.mainNavigation(.question(questions, questionNumber + 1)))
            } else {
                navigationState.routes.append(
                    .mainNavigation(
                        .results(correctAnswers: correctAnswers,
                                 numberOfQuestions: questions.count)
                    )
                )
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuestionView(questions: questionsArrayMock,
                         questionNumber: 2)
        }
    }
}


