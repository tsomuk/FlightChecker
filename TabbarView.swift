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
            
            ServiceView()
                .tabItem { Label("Service", systemImage: "gearshape.2") }
        }
        .tint(.primary)
    }
}

#Preview {
    TabbarView()
}
