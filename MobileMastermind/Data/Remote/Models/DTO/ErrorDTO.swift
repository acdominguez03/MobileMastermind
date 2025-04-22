//
//  ErrorDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

struct ErrorDTO: Decodable, Error {
    let code: Int
    let message: String
    let type: String
}
