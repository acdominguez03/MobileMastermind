//
//  GameViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 6/5/25.
//

import Foundation

@MainActor
@Observable final class GameViewModel {
    var questionNumber = 0
    var timeRemaining: Int = 30
    var progress: CGFloat = 0
    
    var questions: [QuestionVO] = []
    
    var isLoading: Bool = false
    
    var gameId: String = ""
    
    //Preguntas con imagen
    var missingLettersText: String = ""
    var name: String = ""
    
    var isButtonDisabled: Bool = false
    
    var navigateToGameResults: Bool = false
    
    let addGameUseCase: AddGameUseCaseProtocol
    
    init(addGameUseCase: AddGameUseCaseProtocol = AddGameUseCase()) {
        self.addGameUseCase = addGameUseCase
    }
    
    func addGame(categoryId: String) async throws {
        isLoading.toggle()
        let result = try await addGameUseCase.execute(categoryId: categoryId)
        
        switch result {
        case .success(let addGameBO):
            print(addGameBO)
            gameId = addGameBO.gameId
            questions = addGameBO.questions.map { $0.toQuestionVO }
        case .failure(let error):
            isLoading.toggle()
            print(error)
        }
    }
    
    func updateTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if timeRemaining > 0 {
                timeRemaining -= 1
                progress += 0.033
                updateTime()
            } else {
                resetTime()
                updateTime()
            }
        }
    }
    
    func resetTime() {
        timeRemaining = 30
        progress = 0
    }
    
    func initMissingLettersText() {
        missingLettersText = "Quedan \(questions[questionNumber].correctAnswer.count) caracteres"
    }
    
    func checkCorrectAnswer(selectedAnswer: Int) {
        
        isButtonDisabled = true
        
        if (questions[questionNumber].correctAnswer == String(selectedAnswer)) {
            questions[questionNumber].options[selectedAnswer].state = OptionState.Success
            questions[questionNumber].state = OptionState.Success
            questions[questionNumber].time = timeRemaining
        } else {
            questions[questionNumber].options[selectedAnswer].state = OptionState.Error
            questions[questionNumber].options[Int(questions[questionNumber].correctAnswer) ?? 0].state = OptionState.Success
            questions[questionNumber].state = OptionState.Error
        }
        
        questions[questionNumber].selectedAnswer = String(selectedAnswer)
        
        DispatchQueue.global().async {
            sleep(1)
           
            DispatchQueue.main.async {
                self.nextQuestion()
            }
        }
    }
    
    func checkInputNameLength(inputName: String) {
        if timeRemaining > 0 {
            if (questions[questionNumber].correctAnswer.lowercased() == inputName.lowercased()) {
                missingLettersText = "Quedan 0 caracteres"
                questions[questionNumber].state = .Success
                questions[questionNumber].selectedAnswer = inputName
                DispatchQueue.global().async {
                    sleep(1)
                   
                    DispatchQueue.main.async {
                        self.nextQuestion()
                        self.name = ""
                    }
                }
            } else {
                let charsQuestionName = Array(questions[questionNumber].correctAnswer.lowercased())
                let charsInputName = Array(inputName.lowercased())
                
                var matchingLetters = 0
                
                if (charsInputName.count <= charsQuestionName.count) {
                    for i in 0..<charsInputName.count {
                        if charsInputName[i] == charsQuestionName[i] {
                            matchingLetters += 1
                        } else {
                            missingLettersText = "Te equivocaste"
                            return
                        }
                    }
                    
                    missingLettersText = "Quedan \(questions[questionNumber].correctAnswer.count - matchingLetters) caracteres"
                } else {
                    missingLettersText = "Te pasaste por \(charsInputName.count - charsQuestionName.count) caracteres"
                }
                questions[questionNumber].selectedAnswer = inputName
            }
        }
    }
    
    func timeOutResponse() {
        if(questions[questionNumber].image != nil) {
            questions[questionNumber].state = OptionState.Error
            name = ""
        } else {
            questions[questionNumber].options[Int(questions[questionNumber].correctAnswer) ?? 0].state = OptionState.Success
            questions[questionNumber].state = OptionState.Error
        }
        
        DispatchQueue.global().async {
            sleep(1)
           
            DispatchQueue.main.async {
                self.nextQuestion()
            }
        }
    }
    
    func nextQuestion() {
        if(questionNumber < (questions.count - 1)) {
            resetTime()
            questionNumber += 1
            isButtonDisabled = false
        } else {
            navigateToGameResults = true
        }
    }
}
