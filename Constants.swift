//
//  Constants.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 19.05.2025.
//

import Foundation

struct Constants {
    static let apiDashboard = "https://aviationstack.com/dashboard"
    static let apiDocs = "https://aviationstack.com/documentation"
    static let minFlightNumberLength = 2
}


struct UDKeys {
    static let historyOfSearch = "historyOfSearch"
    static let apiKey = "apiKey"
}

enum ApiKeyType: String {
    case primary = "access_key=ab4495bf0c1fb85a94230c9e67b2b2d0" // .code@gmail
    case reserve = "access_key=799097ae8c97af56ad78bcd2dc3e2802" // @ya
}
