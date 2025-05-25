//
//  ApiKeyType.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 25.05.2025.
//


enum ApiKeyType: String {
    case primary = "access_key=ab4495bf0c1fb85a94230c9e67b2b2d0" // code@gmail
    case reserve = "access_key=799097ae8c97af56ad78bcd2dc3e2802" // @ya
    
    var toggled: ApiKeyType {
        self == .primary ? .reserve : .primary
    }
    
    var description: String {
        self == .primary ? "основной" : "резервный"
    }
}
