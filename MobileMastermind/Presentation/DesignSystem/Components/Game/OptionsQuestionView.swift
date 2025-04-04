//
//  OptionsQuestion.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct OptionsQuestionView: View {
    
    var question: QuestionModel
    var isButtonDisabled: Bool
    var checkCorrectAnswer: (Int) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .shadow(radius: 10)
            
            Text(question.title)
                .mediumStyle(size: 20, color: .black)
                .padding(20)
                .multilineTextAlignment(.center)
        }
        
        ForEach(question.options.indices, id: \.self) { index in
            AnswerComponentView(
                option: question.options[index],
                color: question.options[index].state == .Success ? Color.Colors.principalGreen :
                    question.options[index].state == .Error ? Color.Colors.questionErrorRed :
                        .white,
                onClick: {
                    checkCorrectAnswer(index)
                }
            ).disabled(isButtonDisabled)
        }
    }
}

#Preview {
    OptionsQuestionView(question: QuestionModel(id: "1", title: "Cuánto es 2 + 2", options: [OptionModel(value: "3", state: OptionState.Default), OptionModel(value: "4", state: OptionState.Success), OptionModel(value: "5", state: OptionState.Error)], correctAnswer: "1", image: nil, state: OptionState.Default, time: 10, selectedAnswer: "0"), isButtonDisabled: false, checkCorrectAnswer: {_ in})
}
