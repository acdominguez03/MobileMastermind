//
//  QuestionVO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

enum OptionState: Decodable, Encodable {
    case Success
    case Error
    case Default
}

struct OptionModel: Decodable, Encodable {
    var value: String
    var state: OptionState
}

struct QuestionVO: Identifiable, Decodable, Encodable {
    var id: String
    var title: String
    var options: [OptionModel]
    var correctAnswer: String
    var image: String?
    var state: OptionState = .Default
    var time: Int = 0
    var selectedAnswer: String = ""
}
