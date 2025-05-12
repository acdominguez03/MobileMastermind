//
//  ProfileBO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//
import Foundation

struct ProfileBO {
    let totalPoints: Int
    let bestScore: Int
    let ranking: Int
    let categoryStats: [CategoryStatsBO]
}

struct CategoryStatsBO: Identifiable {
    let id: UUID = UUID()
    let bestScore: Int
    let totalHits: Int
    let totalFails: Int
    let totalGames: Int
    let betterQuestion: Int
    let categoryName: String
    let categoryColor: String
}
