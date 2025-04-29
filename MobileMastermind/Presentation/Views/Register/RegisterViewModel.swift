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
    
    var error: String = ""
    
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
        isLoading = true
        let result = try await registerUseCase.execute(username: username, email: email, password: password, image: imageData)
        switch result {
        case .success(let registerBO):
            MobileMastermindDefaultsManager.shared.saveLoginData(accessToken: registerBO.accessToken, refreshToken: registerBO.refreshToken, username: registerBO.user.username, imageURL: registerBO.user.image)
            isLoading = false
            completion()
        case .failure(let error):
            self.error = Utils.shared.checkError(error: error)
            isLoading = false
            print(error)
        }
    }
}


extension RegisterViewModel {
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
