//
//  QuestionDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

struct QuestionDTO: Decodable {
    let id: String?
    let title: String?
    let options: [String]?
    let correctAnswer: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case options
        case correctAnswer
        case image
    }
}

extension QuestionDTO {
    var toQuestionBO: QuestionBO {
        .init(
            id: id ?? "",
            title: title ?? "",
            options: options ?? [],
            correctAnswer: correctAnswer ?? "",
            image: image
        )
    }
}
