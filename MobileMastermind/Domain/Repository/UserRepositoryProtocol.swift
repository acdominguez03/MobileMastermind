//
//  UserRepositoryProtocol.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

protocol UserRepositoryProtocol {
    func login(username: String, password: String) async throws -> LoginBO
    func logout() async throws -> Int
}
