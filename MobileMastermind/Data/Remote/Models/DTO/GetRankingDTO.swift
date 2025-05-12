//
//  GetRankingDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

struct RankingDTO: Decodable {
    let user: UserRankingDTO?
    let totalScore: Int?
}

extension RankingDTO {
    var toRankingBO: RankingBO {
        .init(user: user?.toUserRankingBO ?? UserRankingBO(id: "", username: "", image: ""), totalScore: totalScore ?? 0)
    }
}

struct UserRankingDTO: Decodable {
    let id: String?
    let username: String?
    let image: String?
}

extension UserRankingDTO {
    var toUserRankingBO: UserRankingBO {
        .init(id: id ?? "", username: username ?? "", image: image ?? "")
    }
}
