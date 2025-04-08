//
//  GameView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 4/4/25.
//

import SwiftUI

struct GameView: View {
    @Binding var path: [Routes]
    
    @State var questionNumber = 0
    @State var timeRemaining: Int = 30
    @State var progress: CGFloat = 0
    
    @State private var name: String = ""
    
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
                        
                        Text("\(questionNumber + 1)/10")
                            .mediumStyle(size: 15, color: .black)
                    }
                    
                    HStack {
                        Spacer()
                        CircularProgressView(timeRemaining: timeRemaining, progress: progress, updateTime: {
                            updateTime()
                        })
                        Spacer()
                    }
                    
                    HStack {
                        ForEach(Utils.shared.questions.indices, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(
                                    Utils.shared.questions[i].state == .Success ?  Color.Colors.principalGreen :
                                        Utils.shared.questions[i].state == .Error ? Color.Colors.questionErrorRed : Color.Colors.backgroundResponse
                                )
                                .frame(width: (geometry.size.width + 40) / 14, height: 12)
                        }
                    }.padding(.vertical, 10)
                    
                    if(Utils.shared.questions[questionNumber].image != nil) {
                        ImageQuestionView(
                            question: Utils.shared.questions[questionNumber],
                            checkInputNameLenght: {  },
                            missingLettersText: "Quedan 3 letras",
                            initMissingLetterText: {
                                
                            },
                            name: $name
                        )
                    } else {
                        OptionsQuestionView(
                            question: Utils.shared.questions[questionNumber],
                            isButtonDisabled: false,
                            checkCorrectAnswer: { index in
                                
                            }
                        )
                    }
                }
                .frame(height: geometry.size.height, alignment: .top)
                .padding(.horizontal, 25)
            }
        }
        .background(Color.Colors.background)
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                resetTime()
                questionNumber += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    resetTime()
                    questionNumber += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        navigateToResults()
                    }
                }
            }
        }
    }
    
    func updateTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if timeRemaining > 0 {
                timeRemaining -= 1
                progress += 0.033
                updateTime()
            } else {
                resetTime()
                updateTime()
            }
        }
    }
    
    func resetTime() {
        timeRemaining = 30
        progress = 0
    }
    
    func navigateToResults() {
        path.append(Routes.GameResults)
    }
}

#Preview {
    GameView(path: .constant([]))
}
