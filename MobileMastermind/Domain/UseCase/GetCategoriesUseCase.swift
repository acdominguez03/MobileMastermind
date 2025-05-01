//
//  GetCategoriesUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

protocol GetCategoriesUseCaseProtocol {
    func execute() async throws -> Result<GetCategoriesBO, ErrorDTO>
}

struct GetCategoriesUseCase: GetCategoriesUseCaseProtocol {
    
    let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol = CategoryRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<GetCategoriesBO, ErrorDTO> {
        do {
            let result = try await repository.getCategories()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
