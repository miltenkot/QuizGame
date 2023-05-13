//
//  Constants.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

extension LinearGradient {
    static var backgroundGradient: Self {
        LinearGradient(
            gradient: Gradient(colors: [Color.pink, Color.yellow]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension Font {
    static var primaryTitle: Self {
        Font.system(size: 25, weight: .bold, design: .rounded)
    }
    
    static var primaryContent: Self {
        Font.system(size: 15, weight: .bold, design: .rounded)
    }
}

struct CustomViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .cornerRadius(roundedCornes)
            .padding(3)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(textColor)
            .shadow(radius: 10)
    }
}

struct CustomButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 40
    var answerType: AnswerType = .unvoted
    
    @ViewBuilder
    var backgroundColor: some View {
        switch answerType {
        case .unvoted:
            LinearGradient.backgroundGradient
        case .correct:
            Color.green
        case .bad:
            Color.red
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .padding(8)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .foregroundColor(configuration.isPressed ? .white.opacity(0.5) : .white)
            .shadow(radius: 10)
    }
}

extension View {
    @ViewBuilder func ifElse<Content: View, ElseContent: View>(_ condition: Bool,
                                                               transform: (Self) -> Content,
                                                               elseTransform: (Self) -> ElseContent) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}

extension Dictionary: RawRepresentable where Key == Int, Value == Bool {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),  // convert from String to Data
            let result = try? JSONDecoder().decode([Int: Bool].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),   // data is  Data type
              let result = String(data: data, encoding: .utf8) // coerce NSData to String
        else {
            return "{}"  // empty Dictionary resprenseted as String
        }
        return result
    }

}
