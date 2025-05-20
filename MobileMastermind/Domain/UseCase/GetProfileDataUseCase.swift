//
//  GetProfileDataUseCase.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

protocol GetProfileDataUseCaseProtocol {
    func execute() async throws -> Result<ProfileBO, ErrorDTO>
}

struct GetProfileDataUseCase: GetProfileDataUseCaseProtocol {
    
    let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func execute() async throws -> Result<ProfileBO, ErrorDTO> {
        do {
            let result = try await repository.getProfileData()
            return .success(result)
        } catch {
            let error = error as? ErrorDTO
            return .failure(error ?? ErrorDTO(code: 500, message: "No se pudo conectar con el servidor", type: "ServerError"))
        }
    }
}
