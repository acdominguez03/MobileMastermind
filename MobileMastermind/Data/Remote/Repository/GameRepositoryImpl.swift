//
//  GameRepositoryImpl.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

struct GameRepositoryImpl: GameRepositoryProtocol {
    
    let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource = RemoteDataSource.shared) {
        self.remote = remote
    }
    
    static let shared: GameRepositoryImpl = GameRepositoryImpl(remote: RemoteDataSource.shared)
    
    func getTotalUserPoints() async throws -> TotalPointsBO {
        do {
            let result = try await remote.getTotalUserPoints()
            return result.data.toTotalPointsBO
        } catch {
            throw error
        }
    }
    
    func getLastUserGame() async throws -> LastUserGameBO? {
        do {
            let result = try await remote.getLastUserGame()
            return result.data?.toLastUserGameBO
        } catch {
            throw error
        }
    }
    
    func addGame(categoryId: String) async throws -> AddGameBO {
        do {
            let result = try await remote.addGame(categoryId: categoryId)
            return result.data.toAddGameBO
        } catch {
            throw error
        }
    }
    
    func updateGameStats(gameStats: GameStatsRequest) async throws -> GameStatsBO {
        do {
            let result = try await remote.updateGameStats(gameStats: gameStats)
            return result.data.toGameStatsBO
        } catch {
            throw error
        }
    }
}
