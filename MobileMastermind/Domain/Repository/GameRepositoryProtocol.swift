//
//  GameRepositoryProtocol.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

protocol GameRepositoryProtocol {
    func getTotalUserPoints() async throws -> TotalPointsBO
    func getLastUserGame() async throws -> LastUserGameBO?
    func addGame(categoryId: String) async throws -> AddGameBO
    func updateGameStats(gameStats: GameStatsRequest) async throws -> GameStatsBO
}
