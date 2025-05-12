//
//  AviaButtonLabel.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 12.05.2025.
//


import SwiftUI

struct AviaButtonLabel: View {
    
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .foregroundStyle(color)
            .padding(.vertical, 12)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(color, lineWidth: 2)
            }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        AviaButtonLabel(title: "AVIA TEST", color: .aviaGreen)
            .padding()
    }
}