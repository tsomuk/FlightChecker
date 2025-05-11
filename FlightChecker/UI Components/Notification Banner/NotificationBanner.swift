//
//  ModalNotificationBar.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 05.05.2025.
//

import SwiftUI

struct NotificationBanner: View {
    
    var type: NotificationBannerType
    var text: String
    var duration: Double = 2.5
    let onDismiss: () -> Void
    
    @State private var isVisible: Bool = false
    
    var body: some View {
        VStack {
            if isVisible {
                bannerContent
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer()
        }
        .onAppear {
            showBanner()
        }
    }
    
    private var bannerContent: some View {
        HStack {
            Image(systemName: type.iconName)
                .foregroundStyle(type.iconColor)
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                dismissBanner()
            } label: {
                Image(systemName: "xmark.circle")
                    .tint(.primary)
                    .opacity(0.6)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 65)
        .background(.regularMaterial)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding([.top, .horizontal], 16)
    }
        
    private func showBanner() {
        withAnimation {
            isVisible = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                dismissBanner()
            }
        }
    }
    
    private func dismissBanner() {
        withAnimation {
            isVisible = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
}


#Preview {
    VStack(spacing: 20) {
        NotificationBanner(
            type: .success,
            text: "Ууууууууспех",
            duration: 2.0,
            onDismiss: {},
//            animation: .bouncy
        )
        
        NotificationBanner(
            type: .error,
            text: "Проваааал",
            duration: 2.0,
            onDismiss: {},
//            animation: .bouncy
        )
        
        NotificationBanner(
            type: .warning,
            text: "Предупрежденииие",
            duration: 2.0,
            onDismiss: {},
//            animation: .bouncy
        )
    }
}
