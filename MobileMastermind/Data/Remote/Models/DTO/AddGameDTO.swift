//
//  AddGameDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

struct AddGameDTO: Decodable {
    let gameId: String?
    let questions: [QuestionDTO]?
    let categoryId: String?
    let userId: String?
    let points: Int?
    let hits: Int?
}

extension AddGameDTO {
    var toAddGameBO: AddGameBO {
        .init(
            gameId: gameId ?? "",
            questions: questions?.map { $0.toQuestionBO } ?? []
        )
    }
}
