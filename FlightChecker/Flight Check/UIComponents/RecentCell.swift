//
//  RecentCell.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 24.04.2025.
//

import SwiftUI

struct RecentCell: View {
    
    var flightNumber: String
    
    var body: some View {
        Text(flightNumber)
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.foreground)
            }
            
    }
}

#Preview {
    RecentCell(flightNumber: "AW123")
}
