//
//  FlightCell.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 30.09.2024.
//

import SwiftUI

struct FlightCell: View {

    @State var flightData: FlightModel.FlightData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            airlineTitle
            
            HStack {
//                VStack(alignment: .leading) {
                    airportAndTime(
                        airportFullName: flightData.departure.airport,
                        airportShortName: flightData.departure.iata,
                        alignment: .leading,
                        multiAlignment: .leading,
                        time: flightData.departure.scheduled
                    )
//                }
                
                Spacer()
                
                Image(systemName: "airplane.departure").font(.largeTitle)
                
                Spacer()
                
//                VStack(alignment: .trailing) {
                    airportAndTime(
                        airportFullName: flightData.arrival.airport,
                        airportShortName: flightData.arrival.iata,
                        alignment: .trailing,
                        multiAlignment: .trailing,
                        time: flightData.arrival.scheduled
                    )
//                }
            }
            .foregroundStyle(.primary)
            
            additionalInfo
    
        }
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(.cellBackground)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.3), radius: 10)
    }
    
    private var additionalInfo: some View {
        HStack {
            Text("Status: \n\(flightData.flightStatus.rawValue)")
            Spacer()
            Text("Flight# \n\(flightData.flight.iata)")
            Spacer()
            Text("Terminal 1")
        }
        .foregroundStyle(.gray)
    }
    
    private var airlineTitle: some View {
        Text(flightData.airline.name)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.headline)
                        .foregroundStyle(.primary)
    }
    
   
}

#Preview {
    FlightCell(flightData: FlightModel.MOCK_FlIGHT)
        
        .padding()
}


struct airportAndTime: View {
    
    let airportFullName: String
    let airportShortName: String
    let alignment: Alignment
    let multiAlignment: TextAlignment
    let time: Date?
    
    var body: some View {
        VStack {
            Text(airportFullName)
                .font(.system(size: 9, weight: .light))
                .foregroundStyle(.gray)
                .multilineTextAlignment(multiAlignment)
                .frame(maxWidth: 60, maxHeight: 33, alignment: alignment)
                .lineLimit(2)
            
            Text(airportShortName)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(fixTimeZone(time))
                .font(.title2)
            
            Text(time?.formatted(date: .omitted, time: .shortened) ?? "no data)")
                .foregroundStyle(.gray)
                .font(.caption2)
        }
    }
    
    func fixTimeZone(_ originalData: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "HH:mm"
        if let date = originalData {
            return dateFormatter.string(from: date)
        }
        return "no data"
    }
}



/*
 func extractTime(from dateString: String) -> String {
     let dateFormatter = ISO8601DateFormatter()
     if let date = dateFormatter.date(from: dateString) {
         let time = Date.FormatStyle()
             .hour()
             .minute()
         return date.formatted(time)
     }
     return "no time"
     
 }
 */
