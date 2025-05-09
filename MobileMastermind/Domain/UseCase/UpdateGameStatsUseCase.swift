//
//  UpdateGameStatsUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 8/5/25.
//

import Foundation

protocol UpdateGameStatsUseCaseProtocol {
    func execute(gameStats: GameStatsRequest) async throws -> Result<GameStatsBO, ErrorDTO>
}

struct UpdateGameStatsUseCase: UpdateGameStatsUseCaseProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol = GameRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute(gameStats: GameStatsRequest) async throws -> Result<GameStatsBO, ErrorDTO> {
        do {
            let result = try await repository.updateGameStats(gameStats: gameStats)
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
