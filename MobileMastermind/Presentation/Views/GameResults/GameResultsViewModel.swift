//
//  GameResultsViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 7/5/25.
//

import Foundation

@Observable
@MainActor final class GameResultsViewModel {
    var questions: [QuestionVO] = []
    var gameId: String = ""
    var points: Int = 0
    
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    
    var isLoading: Bool = false
    
    let updateGameStatsUseCase: UpdateGameStatsUseCaseProtocol
    
    init(updateGameStatsUseCase: UpdateGameStatsUseCaseProtocol = UpdateGameStatsUseCase()) {
        self.updateGameStatsUseCase = updateGameStatsUseCase
    }
    
    func updateGameStats() async throws {
        isLoading.toggle()
        let gameStatsRequest = GameStatsRequest(gameId: gameId, results: questions.map({ question in
            QuestionRequest(questionId: question.id, time: question.time, response: question.selectedAnswer)
        }))
        
        let result = try await updateGameStatsUseCase.execute(gameStats: gameStatsRequest)
        
        switch result {
        case .success(let stats):
            points = stats.points
            isLoading.toggle()
        case .failure(let error):
            print(error)
        }
    }
    
    func getAnswersResults() {
        questions.forEach { question in
            switch(question.state) {
                case .Success:
                    correctAnswers += 1
                case .Error:
                    wrongAnswers += 1
                case .Default:
                    break
            }
        }
    }
}
