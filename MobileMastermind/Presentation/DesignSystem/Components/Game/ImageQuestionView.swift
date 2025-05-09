//
//  ImageQuestionCard.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct ImageQuestionView: View {
    var question: QuestionVO
    var checkInputNameLenght: () -> Void
    var missingLettersText: String
    var initMissingLetterText: () -> Void
    
    @Binding var name: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: question.image ?? "")){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                } placeholder: {
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 220)
                }
                
                Text("\(question.title)")
                    .mediumStyle(size: 20, color: .black)
                    .padding(5)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(.white)
                    .clipShape(.rect(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
                
            }
            
            CustomTextField(title: "Nombre", placeholder: "Introduce el nombre", text: $name, onChange: {
                checkInputNameLenght()
            })
            
            Text(missingLettersText)
                .regularStyle(size: 14, color: .black)
                .onAppear {
                    initMissingLetterText()
                }
        }
    }
}

#Preview {
    ImageQuestionView(question: QuestionVO(
        id: "", title: "¿Quién es este jugador?",
        options: [],
        correctAnswer: "Ray Allen",
        image: "https://res.cloudinary.com/dnuejyham/image/upload/v1746722167/ja0min50n7hafzn6bprj.png"
    ), checkInputNameLenght: { }, missingLettersText: "Quedan 9 caracteres", initMissingLetterText: {}, name: .constant(""))
}
