//
//  UserRepositoryProtocol.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func login(username: String, password: String) async throws -> LoginBO
    func register(username: String, email: String, password: String, image: Data) async throws -> RegisterBO
    func logout() async throws -> Int
    func getProfileData() async throws -> ProfileBO
}
