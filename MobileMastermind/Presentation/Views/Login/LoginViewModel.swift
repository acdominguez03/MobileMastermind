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
    
    var errorType: LoginErrors? = nil
    var errorMessage: String = ""
    
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
            checkError(error: error)
            print(error)
        }
    }
    
    func checkError(error: ErrorDTO) {
        errorMessage = Utils.shared.checkError(error: error)
        
        let code = error.code
        switch code {
        case 400...499:
            errorType = LoginErrors.invalidLogin
        case 500:
            errorType = LoginErrors.serverError
        default:
            errorType = LoginErrors.unknownError
        }
    }
}

enum LoginErrors {
    case invalidLogin
    case serverError
    case unknownError
}
