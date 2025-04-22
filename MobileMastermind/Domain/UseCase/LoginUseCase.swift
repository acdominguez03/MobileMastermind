//
//  LoginUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

protocol LoginUseCaseProtocol {
    func execute(username: String, password: String) async throws -> Result<LoginBO, ErrorDTO>
}

struct LoginUseCase: LoginUseCaseProtocol {
    
    let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute(username: String, password: String) async throws -> Result<LoginBO, ErrorDTO> {
        do {
            let result = try await repository.login(username: username, password: password)
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
