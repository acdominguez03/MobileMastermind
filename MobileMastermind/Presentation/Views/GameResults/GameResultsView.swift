//
//  GameResultsView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct GameResultsView: View {
    @Binding var path: [Routes]
    @State var questions: [QuestionModel] = Utils.shared.questions
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text(LocalizedStringKey("results"))
                .titleStyle(size: 30)
            
            ResultComponent(categoryName: "Kotlin", points: 350, hits: 5, errors: 5)
            
            HStack {
                Text(LocalizedStringKey("your_answers"))
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
            
            CustomButton(title: "Next") {
                path.removeLast(2)
            }
        }
        .padding(.horizontal, 25)
        .background(Color.Colors.background)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameResultsView(path: .constant([]))
}

