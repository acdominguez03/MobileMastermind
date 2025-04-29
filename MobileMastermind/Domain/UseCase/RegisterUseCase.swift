//
//  RegisterUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

import Foundation

protocol RegisterUseCaseProtocol {
    func execute(username: String, email: String, password: String, image: Data) async throws -> Result<RegisterBO, ErrorDTO>
}

struct RegisterUseCase: RegisterUseCaseProtocol {
    
    let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute(username: String, email: String, password: String, image: Data) async throws -> Result<RegisterBO, ErrorDTO> {
        do {
            let result = try await repository.register(username: username, email: email, password: password, image: image)
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
