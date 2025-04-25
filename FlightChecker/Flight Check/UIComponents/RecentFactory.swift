//
//  RecentFactory.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 24.04.2025.
//

import SwiftUI

struct RecentFactory: View {
    
    var recentFlight: [String]
    
    var body: some View {
        VStack {
            Text("Recent searches:")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                ForEach(recentFlight, id: \.self) { flight in
                    RecentCell(flightNumber: flight)
                }
                Spacer()
                
                Button {
    //                deleteRecent()
    //                recentFlight.append("NEW12")
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.foreground)
                }
            }
        }
    }
    
    func deleteRecent() {
//        recentFlight.removeLast()
    }
    
}

#Preview {
    var recentFlight: [String] = ["AF123", "AF113", "AF423", "AF123"]
    RecentFactory(recentFlight: recentFlight)
        .padding(.horizontal, 12)
}



// ["AF123", "AF113", "AF423", "AF123"]
