//
//  GetUserRankingUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

protocol GetUserRankingUseCaseProtocol {
    func execute() async throws -> Result<[RankingBO], ErrorDTO>
}

struct GetUserRankingUseCase: GetUserRankingUseCaseProtocol {
    
    let repository: RankingRepositoryProtocol
    
    init(repository: RankingRepositoryProtocol = RankingRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<[RankingBO], ErrorDTO> {
        do {
            let result = try await repository.getUserRanking()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
