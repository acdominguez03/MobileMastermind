//
//  NetworkUtils.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 20/4/25.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

struct NetworkUtils {
    static let shared = NetworkUtils()
    
    let url: String = "https://mobilemastermindapi.onrender.com/api/"
    
    func request(endpoint: String, method: HttpMethod, body: Data?) throws -> URLRequest {
        guard let url = URL(string: endpoint, relativeTo: URL(string: url)) else {
            print("Url inválida")
            throw ErrorResponse(error: ErrorDTO(code: URLError.badURL.rawValue, message: "Url inválid", type: "URLError"))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        return request
    }
    
    func requestWithMultiPartForm(endpoint: String, image: Data, parameters: [String: Any]) throws -> URLRequest {
        guard let url = URL(string: endpoint, relativeTo: URL(string: url)) else {
            print("Url inválida")
            throw ErrorResponse(error: ErrorDTO(code: URLError.badURL.rawValue, message: "Url inválid", type: "URLError"))
        }
        
        let boundary = UUID().uuidString
        let request = createMultipartRequest(url: url, boundary: boundary, parameters: parameters, imageData: image)
        return request
    }
    
    func createMultipartRequest(url: URL, boundary: String, parameters: [String: Any], imageData: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Crear el cuerpo de la solicitud
        var body = Data()
        
        // Agregar parámetros de texto
        parameters.forEach { key, value in
             body.append("--\(boundary)\r\n".data(using: .utf8)!)
             body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
             body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Agregar archivo de imagen
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Finalizar el cuerpo
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        return request
    }
}
