//
//  HomeViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

import Foundation

@Observable
@MainActor final class HomeViewModel {
    var totalPoints: Int = 0
    var lastUserGame: LastUserGameBO? = nil
    var categories: [CategoryBO] = []
    
    var isLoading: Bool = false
    
    let getTotalUserPointsUseCase: GetTotalUserPointsUseCaseProtocol
    let getLastUserGameUseCase: GetLastUserGameUseCaseProtocol
    let getCategoriesUseCase: GetCategoriesUseCaseProtocol
    
    init(
        getTotalUserPointsUseCase: GetTotalUserPointsUseCaseProtocol = GetTotalUserPointsUseCase(),
        getLastUserGameUseCase: GetLastUserGameUseCaseProtocol = GetLastUserGameUseCase(),
        getCategoriesUseCase: GetCategoriesUseCaseProtocol = GetCategoriesUseCase()
    ) {
        self.getTotalUserPointsUseCase = getTotalUserPointsUseCase
        self.getLastUserGameUseCase = getLastUserGameUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getTotalUserPoints() async throws {
        isLoading = true
        
        let result = try await getTotalUserPointsUseCase.execute()
        
        switch result {
        case .success(let totalPointsBO):
            self.totalPoints = totalPointsBO.totalPoints
            try await getLastUserGame()
        case .failure(let error):
            print(error)
            isLoading = false
        }
    }
    
    func getLastUserGame() async throws {
        let result = try await getLastUserGameUseCase.execute()
        
        switch result {
        case .success(let lastUserGameBO):
            self.lastUserGame = lastUserGameBO
            try await getCategories()
        case .failure(let error):
            print(error)
            isLoading = false
        }
    }
    
    func getCategories() async throws {
        let result = try await getCategoriesUseCase.execute()
        
        switch result {
        case .success(let getCategoriesBO):
            self.categories = getCategoriesBO.categories
            isLoading = false
        case .failure(let error):
            print(error)
            isLoading = false
        }
    }
}
