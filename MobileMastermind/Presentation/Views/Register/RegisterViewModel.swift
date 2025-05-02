//
//  RegisterViewModel.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 27/4/25.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
@MainActor class RegisterViewModel {
    let registerUseCase: RegisterUseCaseProtocol
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    
    var errorType: RegisterErrors? = nil
    var errorMessage: String = ""
    
    var isLoading: Bool = false
    
    var image: Image = Image(systemName: "photo.on.rectangle.angled")
    var photoSelection: PhotosPickerItem? {
        didSet {
            if let photoSelection { loadTransferable(from: photoSelection) }
        }
    }
    var imageData: Data = Data()
    
    init(registerUseCase: RegisterUseCaseProtocol = RegisterUseCase()) {
        self.registerUseCase = registerUseCase
    }
    
    func registerUser(completion: @escaping () -> Void) async throws {
        if password == repeatPassword {
            isLoading = true
            let result = try await registerUseCase.execute(username: username, email: email, password: password, image: imageData)
            switch result {
            case .success(let registerBO):
                MobileMastermindDefaultsManager.shared.saveLoginData(accessToken: registerBO.accessToken, refreshToken: registerBO.refreshToken, username: registerBO.user.username, imageURL: registerBO.user.image)
                isLoading = false
                completion()
            case .failure(let error):
                isLoading = false
                checkError(error: error)
                print(error)
            }
        } else {
            errorMessage = "Las contraseñas son distintas"
            errorType = RegisterErrors.repeatPasswordError
        }
    }
}

enum RegisterErrors {
    case username
    case email
    case password
    case repeatPasswordError
    case serverError
    case unknownError
}


extension RegisterViewModel {
    
    private func checkError(error: ErrorDTO) {
        errorMessage = Utils.shared.checkError(error: error)
        
        switch error.code {
        case 400...499:
            if error.type == "username" {
                errorType = RegisterErrors.username
            } else if error.type == "email" {
                errorType = RegisterErrors.email
            } else if error.type == "password" {
                errorType = RegisterErrors.password
            }
        case 500:
            errorType = RegisterErrors.serverError
        default:
            errorType = RegisterErrors.unknownError
        }
    }
     
    private func loadTransferable(from photoSelection: PhotosPickerItem) {
        photoSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard photoSelection == self.photoSelection else { return }
                switch result {
                case .success(let data):
                    print(data!)
                    let uiImage = UIImage(data: data!)
                    self.image = Image(uiImage: uiImage!)
                    self.imageData = data!
                case .failure(let error):
                    print("Error al cargar la imagen\(error)")
                    self.image = Image(systemName: "multiply.circle.fill")
                }
            }
        }
    }
}
