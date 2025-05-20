//
//  RankingViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

import Foundation

@Observable
@MainActor final class RankingViewModel {
    var userRankings: [RankingBO] = []
    
    var isLoading: Bool = false
    
    var errorType: RankingErrors? = nil
    var errorMessage: String = ""
    
    let getUserRankingUseCase: GetUserRankingUseCaseProtocol
    
    init(getUserRankingUseCase: GetUserRankingUseCaseProtocol = GetUserRankingUseCase()) {
        self.getUserRankingUseCase = getUserRankingUseCase
    }
    
    func getUsersRanking() async throws {
        isLoading.toggle()
        
        let result = try await getUserRankingUseCase.execute()
        
        switch result {
        case .success(let usersRanking):
            userRankings = usersRanking
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
            errorType = RankingErrors.tokenExpired
        case 404...500:
            errorType = RankingErrors.serverError
        default:
            errorType = RankingErrors.unknownError
        }
    }
}

enum RankingErrors {
    case tokenExpired
    case serverError
    case unknownError
}
