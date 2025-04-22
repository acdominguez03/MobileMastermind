//
//  LoginDTO.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

struct LoginDTO: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let expiresIn: Int?
    let user: UserLoginDTO?
}

extension LoginDTO {
    var toLoginBO: LoginBO {
        LoginBO(
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            expiresIn: expiresIn ?? 0,
            user: user?.toUserLoginBO ?? UserLoginBO(username: "", image: "")
        )
    }
}


struct UserLoginDTO: Decodable {
    let username: String?
    let image: String?
}

extension UserLoginDTO {
    var toUserLoginBO: UserLoginBO {
        UserLoginBO(username: username ?? "", image: image ?? "")
    }
}
