//
//  AirportList.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 28.10.2024.
//

import SwiftUI

struct AirportList: View {
    
    @State var showBanner = false
    @State private var bannerType: NotificationBannerType = .success
    @State private var bannerTitle: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                Text("Hello, Avia World!")
                    .foregroundStyle(.accent)
                    .font(.title)
                    .bold()
                    .fontWeight(.semibold)
                Image(.airportIcon)
                    .foregroundStyle(.accent)
                
                AviaButton(title: "Success banner") { showSuccessBanner() }
                AviaButton(title: "Error banner") { showErrorBanner() }
                AviaButton(title: "Warning banner") { showWarningBanner() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 30)
//            .background(Color(.red))
            
            if showBanner {
                NotificationBanner(
                    type: bannerType,
                    text: bannerTitle,
                    duration: 2.5,
                    onDismiss: { showBanner = false }
                )
            }
        }
    }
    
    func showSuccessBanner() {
        bannerType = .success
        bannerTitle = "Рейс 3F81 добавлен!"
        showBanner = true
    }
    
    func showErrorBanner() {
        bannerType = .error
        bannerTitle = "Рейс 3F81 не найден!"
        showBanner = true
    }
    
    func showWarningBanner() {
        bannerType = .warning
        bannerTitle = "Ошибка связи с сервером. Повторите попытку"
        showBanner = true
    }
}


#Preview {
    AirportList()
}
