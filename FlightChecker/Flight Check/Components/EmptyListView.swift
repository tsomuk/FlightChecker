//
//  EmptyListView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 10.10.2024.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ZStack {
        Image(systemName: "arrow.turn.right.up")
                .scaleEffect(1.6)
                .padding(.trailing, 25)
                .padding(.top, -45)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        
        
            VStack(spacing: 20) {
                Text("Add new flight \nto track")
                Image(systemName: "airplane.circle")
                    .scaleEffect(1.5)
        
                
            }
            .multilineTextAlignment(.center)
            .font(.largeTitle)
        }
    }
}

#Preview {
//    EmptyListView()
    FlightListView()
}
