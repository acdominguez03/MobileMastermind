//
//  AnswerResultRow.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct AnswerResultRow: View {
    let index: Int
    let state: OptionState
    let question: String
    let correctAnswer: String
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(state == OptionState.Success ? Color.Colors.principalGreen : Color.Colors.questionErrorRed)
                
                Text("Q\(index)")
                    .mediumStyle(size: 20, color: .white)
            }
            
            VStack(alignment: .leading) {
                Text(question)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .mediumStyle(size: 15, color: .black)
                    
                
                Text(correctAnswer)
                    .mediumStyle(size: 15, color: state == OptionState.Success ? Color.Colors.principalGreen : Color.Colors.questionErrorRed)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(state == OptionState.Success ? .QuestionsIcons.successGreen : .QuestionsIcons.failedRed)
                .frame(width: 30, height: 30)
            
        }.padding(.horizontal, 20)
    }
}

#Preview {
    AnswerResultRow(index: 1, state: .Success, question: "¿Quién es este jugador tan guapo e increible que hay en este equipo?", correctAnswer: "Larry Bird")
}
