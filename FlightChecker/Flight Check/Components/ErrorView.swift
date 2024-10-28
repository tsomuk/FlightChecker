//
//  ErrorView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 23.10.2024.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Flight didn't find")
            Image(systemName: "xmark.circle")
        }
        .font(.largeTitle)
        .foregroundStyle(.red)
    }
}

#Preview {
    ErrorView()
}
