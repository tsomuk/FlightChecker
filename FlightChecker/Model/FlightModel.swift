//
//  FlightModelManual.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 30.09.2024.
//

import Foundation

struct FlightModel: Decodable {
    
    let pagination: Pagination
    let data: [FlightData]
    
    struct Pagination: Decodable {
        let limit: Int
        let offset: Int
        let count: Int
        let total: Int
    }
    
    struct FlightData: Decodable {
        let flightDate: String
        let flightStatus: FlightStatus
        let departure: Departure
        let arrival: Arrival
        let airline: Airline
        let flight: Flight
        
        enum CodingKeys: String, CodingKey {
            case flightDate = "flight_date"
            case flightStatus = "flight_status"
            case departure, arrival, airline, flight
        }
    }
    
    struct Departure: Decodable {
        let airport: String
        let iata: String
        let icao: String
        let scheduled: Date?
        let delay: Int?
        
        enum CodingKeys: CodingKey {
            case airport
            case iata
            case icao
            case scheduled
            case delay
        }
        
        init(airport: String, iata: String, icao: String, scheduled: Date?, delay: Int?) {
            self.airport = airport
            self.iata = iata
            self.icao = icao
            self.scheduled = scheduled
            self.delay = delay
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<FlightModel.Departure.CodingKeys> = try decoder.container(keyedBy: FlightModel.Departure.CodingKeys.self)
            self.airport = try container.decode(String.self, forKey: FlightModel.Departure.CodingKeys.airport)
            self.iata = try container.decode(String.self, forKey: FlightModel.Departure.CodingKeys.iata)
            self.icao = try container.decode(String.self, forKey: FlightModel.Departure.CodingKeys.icao)
            self.scheduled = try container.decode(String.self, forKey: FlightModel.Departure.CodingKeys.scheduled).toDate()
            self.delay = try container.decodeIfPresent(Int.self, forKey: FlightModel.Departure.CodingKeys.delay)
        }
        
    }
    
    struct Arrival: Decodable {
        let airport: String
        let iata: String
        let icao: String
        let scheduled: Date?
        let delay: Int?
        
        init(airport: String, iata: String, icao: String, scheduled: Date?, delay: Int?) {
            self.airport = airport
            self.iata = iata
            self.icao = icao
            self.scheduled = scheduled
            self.delay = delay
        }
        enum CodingKeys: CodingKey {
            case airport
            case iata
            case icao
            case scheduled
            case delay
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<FlightModel.Arrival.CodingKeys> = try decoder.container(keyedBy: FlightModel.Arrival.CodingKeys.self)
            self.airport = try container.decode(String.self, forKey: FlightModel.Arrival.CodingKeys.airport)
            self.iata = try container.decode(String.self, forKey: FlightModel.Arrival.CodingKeys.iata)
            self.icao = try container.decode(String.self, forKey: FlightModel.Arrival.CodingKeys.icao)
            self.scheduled = try container.decode(String.self, forKey: FlightModel.Arrival.CodingKeys.scheduled).toDate()
            self.delay = try container.decodeIfPresent(Int.self, forKey: FlightModel.Arrival.CodingKeys.delay)
        }
    }
    
    struct Airline: Decodable {
        let name: String
        //        let iata: String
        //        let icao: String
    }
    
    struct Flight: Decodable {
        //        let number: String
        let iata: String
    }
    
    enum FlightStatus: String, Decodable {
        case scheduled, active, landed, cancelled, incident, diverted
    }
}
    
extension FlightModel.FlightData : Hashable, Identifiable {
    var id: String {
        UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: FlightModel.FlightData, rhs: FlightModel.FlightData) -> Bool {
        return lhs.id == rhs.id
    }
}
    
extension FlightModel {
    static let MOCK_FlIGHT: FlightModel.FlightData = .init(
        flightDate: "2024-10-07",
        flightStatus: FlightStatus.scheduled,
        departure: FlightModel.Departure(
            airport: "Heydar Aliyev International",
            iata: "GYD",
            icao: "UBBB",
            scheduled: Date(),
            delay: 45
        ),
        arrival: FlightModel.Arrival(
            airport: "Ben Gurion International",
            iata: "TLV",
            icao: "LLBG",
            scheduled: Date().addingTimeInterval(7300),
            delay: nil
        ),
        airline: FlightModel.Airline(name: "Israir Airlines"),
        flight: FlightModel.Flight(iata: "6H882")
    )
}

struct MockData: Codable {
    let scheduled: Date?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scheduled = try container.decodeIfPresent(String.self, forKey: .scheduled)?.toDate()
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)

    }
}

extension Date {
    func format(_ timeFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = timeFormat
        return dateFormatter.string(from: self)
    }
}

    
// JSON RESPONSE
/*
 {
     "pagination": {
         "limit": 100,
         "offset": 0,
         "count": 1,
         "total": 1
     },
     "data": [
         {
             "flight_date": "2024-10-07",
             "flight_status": "scheduled",
             "departure": {
                 "airport": "Heydar Aliyev International",
                 "timezone": "Asia/Baku",
                 "iata": "GYD",
                 "icao": "UBBB",
                 "terminal": "T2 N",
                 "gate": null,
                 "delay": 45,
                 "scheduled": "2024-10-07T14:05:00+00:00",
                 "estimated": "2024-10-07T14:05:00+00:00",
                 "actual": null,
                 "estimated_runway": null,
                 "actual_runway": null
             },
             "arrival": {
                 "airport": "Ben Gurion International",
                 "timezone": "Asia/Jerusalem",
                 "iata": "TLV",
                 "icao": "LLBG",
                 "terminal": "3",
                 "gate": null,
                 "baggage": null,
                 "delay": null,
                 "scheduled": "2024-10-07T16:30:00+00:00",
                 "estimated": "2024-10-07T16:30:00+00:00",
                 "actual": null,
                 "estimated_runway": null,
                 "actual_runway": null
             },
             "airline": {
                 "name": "Israir Airlines",
                 "iata": "6H",
                 "icao": "ISR"
             },
             "flight": {
                 "number": "882",
                 "iata": "6H882",
                 "icao": "ISR882",
                 "codeshared": null
             },
             "aircraft": {
                 "registration": "4X-ABT",
                 "iata": "A320",
                 "icao": "A320",
                 "icao24": "738288"
             },
             "live": {
                 "updated": "2024-10-07T10:53:14+00:00",
                 "latitude": 40.4649,
                 "longitude": 50.0481,
                 "altitude": 0,
                 "direction": 208,
                 "speed_horizontal": 3.704,
                 "speed_vertical": 0,
                 "is_ground": true
             }
         }
     ]
 }
 */

