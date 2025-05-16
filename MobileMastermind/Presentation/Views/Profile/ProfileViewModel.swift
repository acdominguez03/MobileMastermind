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
}
