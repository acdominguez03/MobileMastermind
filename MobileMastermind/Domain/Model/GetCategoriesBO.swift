//
//  GetCategoriesBO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

struct GetCategoriesBO {
    let categories: [CategoryBO]
}

struct CategoryBO {
    let id: String
    let name: String
    let image: String
    let type: String
    let numberOfQuizzes: Int
}
