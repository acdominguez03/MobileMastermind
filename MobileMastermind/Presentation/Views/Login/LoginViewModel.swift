//
//  LoginViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

@Observable
@MainActor final class LoginViewModel {
    let loginUseCase: LoginUseCaseProtocol
    
    var username: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    func login(completion: @escaping () -> Void) async throws {
        isLoading = true
        let result = try await loginUseCase.execute(username: username, password: password)
        switch result {
        case .success(let loginBO):
            print(loginBO)
            MobileMastermindDefaultsManager.shared.saveLoginData(accessToken: loginBO.accessToken, refreshToken: loginBO.refreshToken, username: loginBO.user.username, imageURL: loginBO.user.image)
            isLoading = false
            completion()
        case .failure(let error):
            isLoading = false
            print(error)
        }
    }
}
