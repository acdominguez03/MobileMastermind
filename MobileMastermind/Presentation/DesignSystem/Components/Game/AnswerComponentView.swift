//
//  AnswerComponent.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct AnswerComponentView: View {
    var option: OptionModel
    var color: Color
    var onClick: () -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Button(action: {
                onClick()
            }) {
                Text(option.value)
                    .mediumStyle(size: 15, color: option.state == OptionState.Default ? .black : .white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(15)
            }
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if(option.state != OptionState.Default) {
                Image(option.state == OptionState.Success ? .QuestionsIcons.success : .QuestionsIcons.failed)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    VStack {
        AnswerComponentView(option: OptionModel(value: "Kotlin", state: .Default), color: .white, onClick: {})
        AnswerComponentView(option: OptionModel(value: "SwiftUI", state: .Success), color: .Colors.principalGreen, onClick: {})
        AnswerComponentView(option: OptionModel(value: "Android Studio", state: .Error), color: .Colors.questionErrorRed, onClick: {})
    }
    
}
