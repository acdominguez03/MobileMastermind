//
//  LastUserGameDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 30/4/25.
//

struct LastUserGameDTO: Decodable {
    let points: Int?
    let categoryImage: String?
    let categoryColor: String?
}

extension LastUserGameDTO {
    var toLastUserGameBO: LastUserGameBO {
        .init(points: points ?? 0, categoryImage: categoryImage ?? "", categoryColor: categoryColor ?? "")
    }
}
