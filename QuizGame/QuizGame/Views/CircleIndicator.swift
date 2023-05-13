//
//  CircleIndicator.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import SwiftUI

struct CircleIndicator: View {
    @Binding var answear: AnswerType
    
    var color: Color {
        switch answear {
        case .bad:
            return .red
        case .correct:
            return .green
        default:
            return .gray
        }
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
    }
}

struct CircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(answear: .constant(.bad))
    }
}
