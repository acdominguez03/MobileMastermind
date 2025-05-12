//
//  RankingRepositoryProtocol.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

protocol RankingRepositoryProtocol {
    func getUserRanking() async throws -> [RankingBO]
}
