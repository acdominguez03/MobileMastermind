//
//  LoginBO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//


struct LoginBO {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let user: UserLoginBO
}

struct UserLoginBO {
    let username: String
    let image: String
}
