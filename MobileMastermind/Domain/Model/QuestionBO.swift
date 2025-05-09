//
//  QuestionBO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

struct QuestionBO {
    let id: String
    let title: String
    let options: [String]
    let correctAnswer: String
    let image: String?
}

extension QuestionBO {
    var toQuestionVO: QuestionVO {
        .init(id: id, title: title, options: options.map({ value in
            OptionModel(value: value, state: .Default)
        }), correctAnswer: correctAnswer, image: image)
    }
}
