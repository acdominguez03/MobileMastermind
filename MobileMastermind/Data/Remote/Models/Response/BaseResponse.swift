//
//  BaseResponse.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

struct BaseResponse <T: Decodable> : Decodable {
    let code: Int?
    let message: String?
    let data: T
}
