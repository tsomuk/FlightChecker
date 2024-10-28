//
//  WeatherModel.swift
//  Metar W.Lite
//
//  Created by Nikita Tsomuk on 18.09.2023.
//

import Foundation


// MARK: - Weather
struct Weather: Codable {
    let results: Int
    let data: [WeatherData]
}

// MARK: - WeatherData
struct WeatherData: Codable {
    let icao: String
    let barometer: Barometer?
    let ceiling: Ceiling?
    let clouds: [Cloud]?
    let conditions: [Condition]?
    let dewpoint: Dewpoint?
    let elevation: Ceiling?
    let flightCategory: String?
    let humidity: Humidity?
    let observed: String?
    let station: Station?
    let temperature: Dewpoint?
    let rawText: String?
    let visibility: Visibility?
    let wind: Wind?
    
    enum CodingKeys: String, CodingKey {
        case icao, barometer, ceiling, clouds, conditions, dewpoint, elevation
        case flightCategory = "flight_category"
        case humidity, observed, station, temperature
        case rawText = "raw_text"
        case visibility, wind
    }
}

// MARK: - Barometer
struct Barometer: Codable {
    let hg: Double
    let hpa: Int
    let kpa, mb: Double
}

// MARK: - Ceiling
struct Ceiling: Codable {
    let feet, meters: Int?
}
// MARK: - Wind
struct Wind: Codable {
    let degrees : Int
    let speed_kts : Int
}

// MARK: - Cloud
struct Cloud: Codable {
    let baseFeetAgl, baseMetersAgl: Int
    let code, text: String
    let feet, meters: Int
    
    enum CodingKeys: String, CodingKey {
        case baseFeetAgl = "base_feet_agl"
        case baseMetersAgl = "base_meters_agl"
        case code, text, feet, meters
    }
}

// MARK: - Condition
struct Condition: Codable {
    let code, text: String
}

// MARK: - Dewpoint
struct Dewpoint: Codable {
    let celsius, fahrenheit: Int
}

// MARK: - Humidity
struct Humidity: Codable {
    let percent: Int
}

// MARK: - Station
struct Station: Codable {
    let geometry: Geometry
    let location, name, type: String
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [Double]
    let type: String
}

// MARK: - Visibility
struct Visibility: Codable {
    let miles: String
    let milesFloat: Double
    let meters: String
    let metersFloat: Int
    
    enum CodingKeys: String, CodingKey {
        case miles
        case milesFloat = "miles_float"
        case meters
        case metersFloat = "meters_float"
    }
}

// MARK: JSON RESRONSE
/*
{
    "results": 1,
    "data": [
        {
            "icao": "ULLI",
            "barometer": {
                "hg": 29.76,
                "hpa": 1008,
                "kpa": 100.78,
                "mb": 1007.79
            },
            "ceiling": {
                "feet": 400,
                "meters": 122
            },
            "clouds": [
                {
                    "base_feet_agl": 400,
                    "base_meters_agl": 122,
                    "code": "OVC",
                    "text": "Overcast",
                    "feet": 400,
                    "meters": 122
                }
            ],
            "dewpoint": {
                "celsius": 6,
                "fahrenheit": 43
            },
            "elevation": {
                "feet": 82,
                "meters": 25
            },
            "flight_category": "LIFR",
            "humidity": {
                "percent": 93
            },
            "observed": "2024-10-14T04:00:00",
            "station": {
                "geometry": {
                    "coordinates": [
                        30.262501,
                        59.800301
                    ],
                    "type": "Point"
                },
                "location": "Saint Petersburg, Russia",
                "name": "Pulkovo Airport",
                "type": "Airport"
            },
            "temperature": {
                "celsius": 7,
                "fahrenheit": 45
            },
            "raw_text": "ULLI 140400Z 13002MPS 100V170 9999 OVC004 07/06 Q1008 R10R/290050 NOSIG RMK QBB120 OBST OBSC",
            "visibility": {
                "miles": "Greater than 6",
                "miles_float": 6,
                "meters": "9,700",
                "meters_float": 9700
            },
            "wind": {
                "degrees": 130,
                "speed_kph": 7,
                "speed_kts": 4,
                "speed_mph": 5,
                "speed_mps": 2
            }
        }
    ]
}
*/

