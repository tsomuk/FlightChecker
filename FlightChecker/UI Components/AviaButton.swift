//
//  AviaButton.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 27.09.2024.
//

import SwiftUI

struct AviaButton: View {
    
    var title: String
    var color: Color = .accent
    var lineWidth: CGFloat = 2
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .foregroundStyle(color)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(color, lineWidth: lineWidth)
                }
        }
    }
}


#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        AviaButton(title: "Press me") {
            print("Oh my!")
        }
        .padding()
    }
}
