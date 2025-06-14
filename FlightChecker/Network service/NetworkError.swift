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
    case encodingError(underline: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "[invalidURL] Ошибка запроса"
        case .requestFailed(let statusCode):
            return "[requestFailed] Некорректный запрос. httpResponse.statusCode: \(statusCode)"
        case .invalidData:
            return "[invalidData] Некорректные данные"
        case .invalidResponse:
            return "[invalidResponse] Некорректные данные"
        case .parsingError(let underline):
            return "[parsingError] Ошибка парсинга данных \n\(underline)"
        case .emptyAccessToken:
            return "[emptyAccessToken] Ошибка токена"
        case .invalidAccessToken:
            return "[invalidAccessToken] Токен недействителен или просрочен"
        case .encodingError(let error):
            return "[encodingError]" + error.localizedDescription
        case .unknown(let error):
            return "[unknown]" + error.localizedDescription
        }
    }
}
