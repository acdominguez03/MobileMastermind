//
//  GetRankingBO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

struct RankingBO: Equatable {
    let user: UserRankingBO
    let totalScore: Int
}

struct UserRankingBO: Equatable {
    let id: String
    let username: String
    let image: String
}
