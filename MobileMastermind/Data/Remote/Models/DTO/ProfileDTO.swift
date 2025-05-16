//
//  ProfileDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

struct ProfileDTO: Decodable {
    let userId: String?
    let totalPoints: Int?
    let bestScore: Int?
    let ranking: Int?
    let categoryStats: [CategoryStatsDTO]?
}

extension ProfileDTO {
    var toProfileBO: ProfileBO {
        .init(totalPoints: totalPoints ?? 0, bestScore: bestScore ?? 0, ranking: ranking ?? 0, categoryStats: categoryStats?.map({ $0.toCategoryStatsBO}) ?? [])
    }
}

struct CategoryStatsDTO: Decodable {
    let id: String?
    let bestScore: Int?
    let totalHits: Int?
    let totalFails: Int?
    let totalGames: Int?
    let betterQuestion: Int?
    let categoryName: String?
    let categoryColor: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case bestScore
        case totalHits
        case totalFails
        case totalGames
        case betterQuestion
        case categoryName
        case categoryColor
    }
}

extension CategoryStatsDTO {
    var toCategoryStatsBO: CategoryStatsBO {
        .init(bestScore: bestScore ?? 0, totalHits: totalHits ?? 0, totalFails: totalFails ?? 0, totalGames: totalGames ?? 0, betterQuestion: betterQuestion ?? 0, categoryName: categoryName ?? "", categoryColor: categoryColor ?? "")
    }
}
