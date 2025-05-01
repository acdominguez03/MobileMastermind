//
//  TotalPointsDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 29/4/25.
//

struct TotalPointsDTO: Decodable {
    let totalPoints: Int?
}

extension TotalPointsDTO {
    var toTotalPointsBO: TotalPointsBO {
        .init(totalPoints: totalPoints ?? 0)
    }
}
