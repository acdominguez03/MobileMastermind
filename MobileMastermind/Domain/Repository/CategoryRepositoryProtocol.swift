//
//  CategoryRepositoryProtocol.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

protocol CategoryRepositoryProtocol {
    func getCategories() async throws -> GetCategoriesBO
}
