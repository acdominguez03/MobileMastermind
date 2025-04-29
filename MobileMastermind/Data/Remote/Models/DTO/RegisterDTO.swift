//
//  RegisterDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 27/4/25.
//

struct RegisterDTO: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let expiresIn: Int?
    let user: UserRegisterDTO?
}

extension RegisterDTO {
    var toRegisterBO: RegisterBO {
        RegisterBO(
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            expiresIn: expiresIn ?? 0,
            user: user?.toUserRegisterBO ?? UserRegisterBO(username: "", image: "")
        )
    }
}


struct UserRegisterDTO: Decodable {
    let username: String?
    let image: String?
}

extension UserRegisterDTO {
    var toUserRegisterBO: UserRegisterBO {
        UserRegisterBO(username: username ?? "", image: image ?? "")
    }
}
