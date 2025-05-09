//
//  Routes.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

enum Routes: Hashable {
    case Login
    case Register
    case Home
    case Game(categoryId: String, categoryName: String)
    case GameResults(questionsJson: String, gameId: String, categoryName: String)
    case Leaderboard
    case Profile
}
