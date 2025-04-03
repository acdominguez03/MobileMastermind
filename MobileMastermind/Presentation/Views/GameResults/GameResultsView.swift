//
//  GameResultsView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct GameResultsView: View {
    @State var questions: [QuestionModel] = [
        QuestionModel(id: "0", title: "¿Cuál es el resultado?", options: [], correctAnswer: "1,2"),
        QuestionModel(id: "1", title: "Kotlin es totalmente compatible con el código Java y puede usarse junto a él en el mismo proyecto", options: [OptionModel(value: "Verdadero", state: OptionState.Success), OptionModel(value: "Falso", state: OptionState.Error)], correctAnswer: "0"),
        QuestionModel(id: "2", title: "¿Cuál de las siguientes opciones es la forma correcta de declarar una variable inmutable en Kotlin?", options: [OptionModel(value: "val nombre = 'Kotlin'", state: OptionState.Default)], correctAnswer: "0"),
        QuestionModel(id: "3", title: "¿Quién es este jugador?", options: [OptionModel(value: "Andres", state: OptionState.Default)], correctAnswer: "0")
    ]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text(LocalizedStringKey("results"))
                .titleStyle(size: 30)
            
            ResultComponent(categoryName: "Kotlin", points: 350, hits: 5, errors: 5)
            
            HStack {
                Text(LocalizedStringKey("your_results"))
                    .mediumStyle(size: 20, color: .black)
                Spacer()
            }
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(Array(questions.enumerated()), id: \.offset) { (index, question) in
                        AnswerResultRow(
                            index: index + 1,
                            state: question.state,
                            question: question.title,
                            correctAnswer: question.options.isEmpty ? question.correctAnswer : question.options[Int(question.correctAnswer) ?? 0].value
                        )
                    }
                }
                .padding(.vertical, 20)
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
            )
            
            CustomButton(title: "Next") {}
        }
        .padding(.horizontal, 25)
        .background(Color.Colors.background)
    }
}

#Preview {
    GameResultsView(questions: [])
}

