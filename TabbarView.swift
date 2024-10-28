//
//  TabbarView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 27.09.2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            FlightListView()
                .tabItem { Label("Flight check", systemImage: "airplane") }
            
            Text("Second view")
                .tabItem { Label("Airport", systemImage: "airplane.departure") }
            
        }
        .tint(.primary)
    }
}

#Preview {
    TabbarView()
}
