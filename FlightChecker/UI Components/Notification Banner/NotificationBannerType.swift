//
//  NotificationBannerType.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 11.05.2025.
//

import SwiftUI

enum NotificationBannerType {
    case success
    case update
    case error
    case warning
    
    
    // Computed property to set icon color
    var iconColor: Color {
        switch self {
        case .success:
            return .accent
        case .error:
            return .red
        case .warning:
            return .yellow
        case .update:
            return .green
        }
    }
    // Computed property to set icon
    var iconName: String {
        switch self {
        case .success:
            return "checkmark"
        case .error:
            return "exclamationmark.triangle"
        case .warning:
            return "exclamationmark.octagon"
        case .update:
            return "arrow.trianglehead.2.clockwise.rotate.90"
        }
    }
}
