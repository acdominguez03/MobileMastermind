//
//  ErrorResponse.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

struct ErrorResponse: Decodable, Error {
    let error: ErrorDTO
}
