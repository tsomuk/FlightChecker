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
}

enum ApiKey: String {
    case flightApiKey = "access_key=ab4495bf0c1fb85a94230c9e67b2b2d0"
    case flightApiKeyReserve = "access_key=8dfc79dff80781b21c079ff4a3f0481e"
}
