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
    
    var errorType: HomeErrors? = nil
    var errorMessage: String = ""
    
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
        errorType = nil
        isLoading = true
        
        let result = try await getTotalUserPointsUseCase.execute()
        
        switch result {
        case .success(let totalPointsBO):
            self.totalPoints = totalPointsBO.totalPoints
            try await getLastUserGame()
        case .failure(let error):
            print(error)
            checkError(error: error)
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
            checkError(error: error)
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
            checkError(error: error)
            isLoading = false
        }
    }
    
    private func checkError(error: ErrorDTO) {
        errorMessage = Utils.shared.checkError(error: error)
        
        switch error.code {
        case 403:
            errorType = HomeErrors.tokenExpired
        case 403...499:
            errorType = HomeErrors.categoriesError
        case 500:
            errorType = HomeErrors.serverError
        default:
            errorType = HomeErrors.unknownError
        }
    }
}

enum HomeErrors {
    case tokenExpired
    case categoriesError
    case serverError
    case unknownError
}
