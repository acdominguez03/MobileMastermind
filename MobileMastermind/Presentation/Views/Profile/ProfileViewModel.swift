//
//  ProfileViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 21/4/25.
//

import Foundation

@Observable
@MainActor final class ProfileViewModel {
    let logoutUseCase: LogoutUseCaseProtocol
    
    var isLoading: Bool = false
    
    init(logoutUseCase: LogoutUseCaseProtocol = LogoutUseCase()) {
        self.logoutUseCase = logoutUseCase
    }
    
    func logout(completion: @escaping () -> Void) async throws {
        isLoading = true
        let result = try await logoutUseCase.execute()
        switch result {
        case .success(let code):
            print(code)
            if code == 200 {
                isLoading = false
                completion()
            }
        case .failure(let error):
            isLoading = false
            print(error)
        }
    }
}
