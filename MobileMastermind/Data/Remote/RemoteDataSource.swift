//
//  RemoteDataSource.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func login(username: String, password: String) async throws -> BaseResponse<LoginDTO>
    func register(username: String, email: String, password: String, image: Data) async throws -> BaseResponse<RegisterDTO>
    func logout() async throws -> BaseResponse<EmptyDataDTO>
}

struct RemoteDataSource: RemoteDataSourceProtocol {
    
    private init() {}
    
    static let shared: RemoteDataSource = RemoteDataSource()
    
    func login(username: String, password: String) async throws -> BaseResponse<LoginDTO> {
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            throw ErrorResponse(error: ErrorDTO(code: 500, message: "La codificación de los datos recibidos no ha salido correctamente", type: "iOSError"))
        }
        
        let request = try NetworkUtils.shared.request(endpoint: UsersEndpoints.login.rawValue, method: HttpMethod.post, body: bodyData)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos del login")
            return try JSONDecoder().decode(BaseResponse<LoginDTO>.self, from: data)
        } catch {
            print("Error al decodificar el login")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    func register(username: String, email: String, password: String, image: Data) async throws -> BaseResponse<RegisterDTO> {
        let body: [String: Any] = [
            "username": username,
            "password": password,
            "email": email
        ]
        
        let request = try NetworkUtils.shared.requestWithMultiPartForm(endpoint: UsersEndpoints.register.rawValue, image: image, parameters: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("decodificacion empezada")
            return try JSONDecoder().decode(BaseResponse<RegisterDTO>.self, from: data)
        } catch {
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            print("Error obtenido: \(result)")
            throw result.error
        }
    }
    
    func logout() async throws -> BaseResponse<EmptyDataDTO> {
        var request = try NetworkUtils.shared.request(endpoint: UsersEndpoints.logout.rawValue, method: .post, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos del logout")
            return try JSONDecoder().decode(BaseResponse<EmptyDataDTO>.self, from: data)
        } catch {
            print("Error al decodificar el logout")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
}
