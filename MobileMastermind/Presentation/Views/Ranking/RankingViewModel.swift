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
}
