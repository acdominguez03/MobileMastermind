//
//  GetTotalUserPointsUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

protocol GetTotalUserPointsUseCaseProtocol {
    func execute() async throws -> Result<TotalPointsBO, ErrorDTO>
}

struct GetTotalUserPointsUseCase: GetTotalUserPointsUseCaseProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol = GameRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<TotalPointsBO, ErrorDTO> {
        do {
            let result = try await repository.getTotalUserPoints()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
