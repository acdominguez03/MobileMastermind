//
//  GameStatsDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 8/5/25.
//

struct GameStatsDTO: Decodable {
    let points: Int?
    let hits: Int?
}


extension GameStatsDTO {
    var toGameStatsBO: GameStatsBO {
        .init(points: points ?? 0)
    }
}
