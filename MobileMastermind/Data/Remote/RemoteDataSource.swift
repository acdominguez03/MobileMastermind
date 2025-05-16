//
//  RemoteDataSource.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

protocol RemoteDataSourceProtocol {
    //USERS
    func login(username: String, password: String) async throws -> BaseResponse<LoginDTO>
    func register(username: String, email: String, password: String, image: Data) async throws -> BaseResponse<RegisterDTO>
    func logout() async throws -> BaseResponse<EmptyDataDTO>
    func getProfileData() async throws -> BaseResponse<ProfileDTO>
    
    //GAME
    func getTotalUserPoints() async throws -> BaseResponse<TotalPointsDTO>
    func getLastUserGame() async throws -> BaseResponse<LastUserGameDTO?>
    func addGame(categoryId: String) async throws -> BaseResponse<AddGameDTO>
    func updateGameStats(gameStats: GameStatsRequest) async throws -> BaseResponse<GameStatsDTO>
    
    //CATEGORY
    func getCategories() async throws -> BaseResponse<GetCategoriesDTO>
    
    //RANKING
    func getRanking() async throws -> BaseResponse<[RankingDTO]>
}

struct RemoteDataSource: RemoteDataSourceProtocol {
    
    private init() {}
    
    static let shared: RemoteDataSource = RemoteDataSource()
    
    //USERS
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
    
    func getProfileData() async throws -> BaseResponse<ProfileDTO> {
        var request = try NetworkUtils.shared.request(endpoint: UsersEndpoints.profile.rawValue, method: .get, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos del perfil")
            return try JSONDecoder().decode(BaseResponse<ProfileDTO>.self, from: data)
        } catch {
            print("Error al decodificar el perfil")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    
    //GAMES
    func getTotalUserPoints() async throws -> BaseResponse<TotalPointsDTO> {
        var request = try NetworkUtils.shared.request(endpoint: GameEndpoints.getTotalPoints.rawValue, method: .get, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos de obtención de puntos del usuario")
            return try JSONDecoder().decode(BaseResponse<TotalPointsDTO>.self, from: data)
        } catch {
            print("Error al decodificar los datos de obtención de puntos del usuario")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    func getLastUserGame() async throws -> BaseResponse<LastUserGameDTO?> {
        var request = try NetworkUtils.shared.request(endpoint: GameEndpoints.getLastUserGame.rawValue, method: .get, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos de obtención de la última partida del usuario")
            return try JSONDecoder().decode(BaseResponse<LastUserGameDTO?>.self, from: data)
        } catch {
            print("Error al decodificar los datos de obtención de la última partida del usuario")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    func addGame(categoryId: String) async throws -> BaseResponse<AddGameDTO> {
        let body: [String: Any] = [
            "categoryId": categoryId
        ]
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            throw ErrorResponse(error: ErrorDTO(code: 500, message: "La codificación de los datos recibidos no ha salido correctamente", type: "iOSError"))
        }
        
        var request = try NetworkUtils.shared.request(endpoint: GameEndpoints.addGame.rawValue, method: .post, body: bodyData)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos de la partida")
            return try JSONDecoder().decode(BaseResponse<AddGameDTO>.self, from: data)
        } catch {
            print("Error al decodificar los datos de la partida")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    func updateGameStats(gameStats: GameStatsRequest) async throws -> BaseResponse<GameStatsDTO> {
        let resultsArray = gameStats.results.map { questionRequest in
            return ["questionId": questionRequest.questionId, "time": questionRequest.time, "response": questionRequest.response]
        }
        let body: [String: Any] = ["gameId": gameStats.gameId, "results": resultsArray]
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            throw ErrorResponse(error: ErrorDTO(code: 500, message: "La codificación de los datos recibidos no ha salido correctamente", type: "iOSError"))
        }
        
        var request = try NetworkUtils.shared.request(endpoint: GameEndpoints.updateGameStats.rawValue, method: .post, body: bodyData)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos de las estadísticas de la partida")
            return try JSONDecoder().decode(BaseResponse<GameStatsDTO>.self, from: data)
        } catch {
            print("Error al decodificar las estadísticas de la partida")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    //CATEGORIES
    func getCategories() async throws -> BaseResponse<GetCategoriesDTO> {
        var request = try NetworkUtils.shared.request(endpoint: CategoryEndpoints.getCategories.rawValue, method: .get, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos de obtención de las categorías")
            return try JSONDecoder().decode(BaseResponse<GetCategoriesDTO>.self, from: data)
        } catch {
            print("Error al decodificar los datos de obtención de las categorías")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
    //RANKING
    func getRanking() async throws -> BaseResponse<[RankingDTO]> {
        var request = try NetworkUtils.shared.request(endpoint: RankingEndpoints.getUserRanking.rawValue, method: .get, body: nil)
        request.setValue("Bearer \(MobileMastermindDefaultsManager.shared.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            print("Decodificando los datos del ranking de usuarios")
            return try JSONDecoder().decode(BaseResponse<[RankingDTO]>.self, from: data)
        } catch {
            print("Error al decodificar los datos del ranking de usuarios")
            let result = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw result.error
        }
    }
    
}
