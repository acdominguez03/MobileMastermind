//
//  GetCategoriesDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

struct GetCategoriesDTO: Decodable {
    let categories: [CategoryDTO]
}

extension GetCategoriesDTO {
    var toGetCategoriesBO: GetCategoriesBO {
        .init(categories: self.categories.map({ categoryDTO in
            categoryDTO.toCategoryBO
        }))
    }
}

struct CategoryDTO: Decodable {
    let id: String?
    let name: String?
    let image: String?
    let color: String?
    let type: String?
    let numberOfQuizzes: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case image
        case color
        case type
        case numberOfQuizzes
    }
}

extension CategoryDTO {
    var toCategoryBO: CategoryBO {
        .init(
            id: id ?? "",
            name: name ?? "Unknown",
            image: image ?? "",
            type: type ?? "Unknown",
            color: color ?? "",
            numberOfQuizzes: numberOfQuizzes ?? 10
        )
    }
}
