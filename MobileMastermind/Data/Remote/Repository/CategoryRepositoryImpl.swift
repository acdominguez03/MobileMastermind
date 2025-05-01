//
//  CategoryRepositoryImpl.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

struct CategoryRepositoryImpl: CategoryRepositoryProtocol {
    
    let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource = RemoteDataSource.shared) {
        self.remote = remote
    }
    
    static let shared: CategoryRepositoryProtocol = CategoryRepositoryImpl(remote: RemoteDataSource.shared)
    
    func getCategories() async throws -> GetCategoriesBO {
        do {
            let result = try await remote.getCategories()
            return result.data.toGetCategoriesBO
        } catch {
            throw error
        }
    }
}
