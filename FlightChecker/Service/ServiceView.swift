//
//  AirportList.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 28.10.2024.
//

import SwiftUI

struct ServiceView: View {
    
    @State var showBanner = false
    @State private var bannerType: NotificationBannerType = .success
    @State private var bannerTitle: String = ""
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .accent
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.accent], for: .normal)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                VStack (spacing: 15) {
                    imageWithText("Hello, Avia World!")
                    
                    Picker("Banner type", selection: $bannerType) {
                        Text("Success").tag(NotificationBannerType.success)
                        Text("Error").tag(NotificationBannerType.error)
                        Text("Warning").tag(NotificationBannerType.warning)
                        Text("Update").tag(NotificationBannerType.update)
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, 40)
                  
                    AviaButton(title: "Show banner") {
                        switch bannerType {
                        case .success:
                            showSuccessBanner()
                        case .update:
                            showUpdateBanner()
                        case .error:
                            showErrorBanner()
                        case .warning:
                            showWarningBanner()
                        }
                    }
                }
                
                Divider()
                
                VStack (spacing: 12) {
                    imageWithText("Api Doc")
                    
                    Link(destination: URL(string: Constants.apiDashboard)!) {
                        AviaButtonLabel(title: "Dashboard", color: .accent)
                    }
                    
                    Link(destination: URL(string: Constants.apiDashboard)!) {
                        AviaButtonLabel(title: "Documentation", color: .accent)
                    }
                }
                
                Divider()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            
            if showBanner {
                NotificationBanner(
                    type: bannerType,
                    text: bannerTitle,
                    duration: 3,
                    onDismiss: { showBanner = false }
                )
            }
        }
    }
    
    private func imageWithText(_ title: String) -> some View {
        HStack(spacing: 20) {
            Image(.airportIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .foregroundStyle(.accent)
            
            Text(title)
                .foregroundStyle(.accent)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    
    func showUpdateBanner() {
        bannerType = .update
        bannerTitle = "Данные по рейсам обновлены"
        showBanner = true
    }
    
    func showWarningBanner() {
        bannerType = .warning
        bannerTitle = "Ошибка связи с сервером. Повторите попытку"
        showBanner = true
    }
}


#Preview {
    ServiceView()
}
