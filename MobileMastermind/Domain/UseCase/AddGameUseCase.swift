//
//  AddGameUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

protocol AddGameUseCaseProtocol {
    func execute(categoryId: String) async throws -> Result<AddGameBO, ErrorDTO>
}

struct AddGameUseCase: AddGameUseCaseProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol = GameRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute(categoryId: String) async throws -> Result<AddGameBO, ErrorDTO> {
        do {
            let result = try await repository.addGame(categoryId: categoryId)
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
