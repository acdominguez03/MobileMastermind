//
//  GameResultsView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct GameResultsView: View {
    @Binding var path: [Routes]
    
    @State private var viewModel: GameResultsViewModel = GameResultsViewModel()
    
    var questionsJson: String
    var gameId: String
    var categoryName: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                Text(LocalizedStringKey("results"))
                    .titleStyle(size: 30)
                
                ResultComponent(categoryName: categoryName, points: viewModel.points, hits: viewModel.correctAnswers, errors: viewModel.wrongAnswers)
                
                HStack {
                    Text(LocalizedStringKey("your_answers"))
                        .mediumStyle(size: 20, color: .black)
                    Spacer()
                }
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(Array(viewModel.questions.enumerated()), id: \.offset) { (index, question) in
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
            
            LoadingView(isLoading: $viewModel.isLoading)
            
            if (viewModel.errorType != nil && viewModel.errorType != GameResultsErrors.tokenExpired) {
                CustomAlert(message: viewModel.errorMessage) {
                    Task {
                        try await viewModel.updateGameStats()
                    }
                }
            }
            
        }
        .background(Color.Colors.background)
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                viewModel.questions = Utils.shared.decodeQuestions(questionsJson)
                viewModel.gameId = gameId
                viewModel.getAnswersResults()
                try await viewModel.updateGameStats()
            }
        }
        .onChange(of: viewModel.errorType) { oldValue, newValue in
            if(newValue == GameResultsErrors.tokenExpired) {
                path.removeAll()
            }
        }
    }
}

#Preview {
    GameResultsView(path: .constant([]), questionsJson: "", gameId: "", categoryName: "")
}

