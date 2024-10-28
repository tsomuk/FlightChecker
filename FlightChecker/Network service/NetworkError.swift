//
//  NetworkError.swift
//  messenger_iOS
//
//  Created by Nikita Tsomuk on 19.07.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case invalidData
    case parsingError(underline: Error)
    case emptyAccessToken
    case invalidAccessToken
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Ошибка запроса"
        case .requestFailed(let statusCode):
            return "[requestFailed] Некорректный запрос. httpResponse.statusCode: \(statusCode)"
        case .invalidData:
            return "[invalidData] Некорректные данные"
        case .invalidResponse:
            return "[invalidResponse] Некорректные данные"
        case .parsingError:
            return "[parsingError] Ошибка парсинга данных"
        case .emptyAccessToken:
            return "[emptyAccessToken] Ошибка токена"
        case .invalidAccessToken:
            return "Токен недействителен или просрочен"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
