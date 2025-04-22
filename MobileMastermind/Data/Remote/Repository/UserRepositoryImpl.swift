//
//  UserRepositoryImpl.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

struct UserRepositoryImpl: UserRepositoryProtocol {
    
    let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource = RemoteDataSource.shared) {
        self.remote = remote
    }
    
    static let shared: UserRepositoryImpl = UserRepositoryImpl(remote: RemoteDataSource.shared)
    
    func login(username: String, password: String) async throws -> LoginBO {
        do {
            let result = try await remote.login(username: username, password: password)
            return result.data.toLoginBO
        } catch {
            throw error
        }
    }
    
    func logout() async throws -> Int {
        do {
            let result = try await remote.logout()
            return result.code ?? 500
        } catch {
            throw error
        }
    }
}
