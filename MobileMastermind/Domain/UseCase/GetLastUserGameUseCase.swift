//
//  GetTotalUserPointsUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

protocol GetLastUserGameUseCaseProtocol {
    func execute() async throws -> Result<LastUserGameBO?, ErrorDTO>
}

struct GetLastUserGameUseCase: GetLastUserGameUseCaseProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol = GameRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<LastUserGameBO?, ErrorDTO> {
        do {
            let result = try await repository.getLastUserGame()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
