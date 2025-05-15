//
//  EmptyListView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 10.10.2024.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
            VStack(spacing: 25) {
                Text("Add new flight \nto track")
                Image(systemName: "airplane.departure")
                    .scaleEffect(1.5)  
            }
            .multilineTextAlignment(.center)
            .font(.largeTitle)
    }
}

#Preview("Empty") {
    EmptyListView()
}

#Preview("List") {
    FlightListView()
}
