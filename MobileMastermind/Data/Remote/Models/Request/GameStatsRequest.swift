//
//  GameStatsRequest.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 7/5/25.
//

struct GameStatsRequest: Codable {
    let gameId: String
    let results: [QuestionRequest]
}
        
struct QuestionRequest: Codable {
    let questionId: String
    let time: Int
    let response: String
}
