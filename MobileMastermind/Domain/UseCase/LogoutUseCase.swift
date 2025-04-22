//
//  LogoutUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 21/4/25.
//

protocol LogoutUseCaseProtocol {
    func execute() async throws -> Result<Int, ErrorDTO>
}

struct LogoutUseCase: LogoutUseCaseProtocol {
    
    let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<Int, ErrorDTO> {
        do {
            let result = try await repository.logout()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
