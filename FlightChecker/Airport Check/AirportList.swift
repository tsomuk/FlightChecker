//
//  AirportList.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 28.10.2024.
//

import SwiftUI

struct AirportList: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Hello, World!")
                .foregroundStyle(.accent)
                .font(.title)
                .bold()
                .fontWeight(.semibold)
            Image(.airportIcon)
                .foregroundStyle(.accent)
        }
    }
}

#Preview {
    AirportList()
}
