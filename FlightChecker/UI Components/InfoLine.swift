//
//  InfoLine.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 27.09.2024.
//

import SwiftUI

struct InfoLine: View {
    
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Menlo", size: 15))
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .font(.custom("Menlo", size: 16))
                .lineLimit(2)
                .minimumScaleFactor(0.4)
                .multilineTextAlignment(.trailing)
        }
        .foregroundStyle(.green)
    }
}

#Preview {
    InfoLine(title: "AIRPORT", value: "Pulkovo International")
        .padding()
        .background(Color.black)
        .padding()
}
