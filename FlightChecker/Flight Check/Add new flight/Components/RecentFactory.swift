//
//  RecentFactory.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 24.04.2025.
//

import SwiftUI

struct RecentFactory: View {
    
    var recentFlight: [String]
    var cleanHistoryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Recent searches:")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                ForEach(recentFlight.reversed().prefix(4), id: \.self) { flight in
                    RecentCell(flightNumber: flight)
                }
                Spacer()
                
                Button {
                    cleanHistoryAction()
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.foreground)
                        .opacity(0.8)
                }
            }
        }
    }
}

#Preview {
    let recentFlight: [String] = ["AF123", "AF113", "AF423", "AF999"]
    RecentFactory(recentFlight: recentFlight, cleanHistoryAction: {})
        .padding(.horizontal, 12)
}



// ["AF123", "AF113", "AF423", "AF123"]
