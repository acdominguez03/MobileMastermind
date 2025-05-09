//
//  GameView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 4/4/25.
//

import SwiftUI

struct GameView: View {
    @Binding var path: [Routes]
    var categoryId: String
    var categoryName: String
    
    @State private var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Button {
                            path.removeLast()
                        } label: {
                            Image(systemName: "arrow.left")
                                .tint(Color.black)
                        }
                        
                        Spacer()
                        
                        Text("\(viewModel.questionNumber + 1)/10")
                            .mediumStyle(size: 15, color: .black)
                    }
                    
                    HStack {
                        Spacer()
                        CircularProgressView(timeRemaining: viewModel.timeRemaining, progress: viewModel.progress, updateTime: {
                            viewModel.updateTime()
                        })
                        Spacer()
                    }
                    
                    if (viewModel.questions.count > 0) {
                        questionsMarcks(questions: viewModel.questions, geometry: geometry)
                        
                        if(viewModel.questions[viewModel.questionNumber].image != nil) {
                            ImageQuestionView(
                                question: viewModel.questions[viewModel.questionNumber],
                                checkInputNameLenght: {
                                    viewModel.checkInputNameLength(inputName: viewModel.name)
                                },
                                missingLettersText: viewModel.missingLettersText,
                                initMissingLetterText: {
                                    viewModel.initMissingLettersText()
                                },
                                name: $viewModel.name
                            )
                        } else {
                            OptionsQuestionView(
                                question: viewModel.questions[viewModel.questionNumber],
                                isButtonDisabled: viewModel.isButtonDisabled,
                                checkCorrectAnswer: { index in
                                    viewModel.checkCorrectAnswer(selectedAnswer: index)
                                }
                            )
                        }
                    }
                }
                .frame(height: geometry.size.height, alignment: .top)
                .padding(.horizontal, 25)
                .onChange(of: viewModel.timeRemaining, {
                    if(viewModel.timeRemaining == 0) {
                        viewModel.timeOutResponse()
                    }
                })
                .onChange(of: viewModel.navigateToGameResults, {
                    DispatchQueue.main.async {
                        path.append(Routes.GameResults(
                            questionsJson: Utils.shared.encodeQuestions(viewModel.questions),
                            gameId: viewModel.gameId,
                            categoryName: categoryName)
                        )
                    }
                })
                .onAppear {
                    Task {
                        try await viewModel.addGame(categoryId: categoryId)
                    }
                }
            }
        }
        .background(Color.Colors.background)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension GameView {
    func questionsMarcks(questions: [QuestionVO], geometry: GeometryProxy) -> some View {
        HStack {
            ForEach(questions.indices, id: \.self) { i in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(
                                questions[i].state == .Success ? Color.Colors.principalGreen :
                                questions[i].state == .Error ? Color.Colors.questionErrorRed :
                                Color.Colors.backgroundResponse
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: 12)
                }
        }.padding(.vertical, 10)
    }
}

#Preview {
    GameView(path: .constant([]), categoryId: "", categoryName: "")
}
