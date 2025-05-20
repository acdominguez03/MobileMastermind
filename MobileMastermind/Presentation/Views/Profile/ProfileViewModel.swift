//
//  ProfileViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 21/4/25.
//

import Foundation

@Observable
@MainActor final class ProfileViewModel {
    var totalPoints: Int = 0
    var bestScore: Int = 0
    var ranking: Int = 0
    var categoryStats: [CategoryStatsBO] = []
    
    var isLoading: Bool = false
    
    var errorType: ProfileErrors? = nil
    var errorMessage: String = ""
    
    let logoutUseCase: LogoutUseCaseProtocol
    let getProfileDataUseCase: GetProfileDataUseCaseProtocol
    
    init(logoutUseCase: LogoutUseCaseProtocol = LogoutUseCase(), getProfileDataUseCase: GetProfileDataUseCaseProtocol = GetProfileDataUseCase()) {
        self.logoutUseCase = logoutUseCase
        self.getProfileDataUseCase = getProfileDataUseCase
    }
    
    func logout(completion: @escaping () -> Void) async throws {
        isLoading.toggle()
        let result = try await logoutUseCase.execute()
        switch result {
        case .success(let code):
            print(code)
            if code == 200 {
                isLoading.toggle()
                completion()
            }
        case .failure(let error):
            checkError(error: error)
            isLoading.toggle()
            print(error)
        }
    }
    
    func getProfileData() async throws {
        isLoading.toggle()
        
        let result = try await getProfileDataUseCase.execute()
        
        switch result {
        case .success(let profileBO):
            totalPoints = profileBO.totalPoints
            bestScore = profileBO.bestScore
            ranking = profileBO.ranking
            categoryStats = profileBO.categoryStats
            isLoading.toggle()
        case .failure(let error):
            print(error)
            isLoading.toggle()
        }
    }
    
    func checkError(error: ErrorDTO) {
        errorMessage = Utils.shared.checkError(error: error)
        
        let code = error.code
        switch code {
        case 403:
            errorType = ProfileErrors.tokenExpired
        case 404...500:
            errorType = ProfileErrors.serverError
        default:
            errorType = ProfileErrors.unknownError
        }
    }
}

enum ProfileErrors {
    case tokenExpired
    case serverError
    case unknownError
}
