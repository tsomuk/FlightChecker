//
//  FlightCardListView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 30.09.2024.
//

import SwiftUI

struct MainScreenFactory: View {
    
    @StateObject var vm = FlightViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch vm.screenState {
                case .empty:
                    ContentUnavailableView("No flights",
                                           systemImage: "airplane.departure",
                                           description: Text("Please add new flight to track"))
                case .loading:
                    ProgressView().scaleEffect(2)
                case .list:
                    FlightListView(vm: vm)
                }
            }
            .navigationTitle("Favorite Flights")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.showAddNewFlight = true
                    } label: {
                        Image(systemName: "plus.square")
                            .tint(.primary)
                    }
                }
                if !vm.flightsNumbers.isEmpty {
                    ToolbarItem(placement: .topBarLeading) { EditButton()
                            .tint(.primary)
                    }
                }
            }
            .sheet(isPresented: $vm.showAddNewFlight) {
                AddNewFlightView(vm: vm)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(235)])
            }
        }
        .overlay {
            if vm.showBanner {
                NotificationBanner(
                    type: vm.bannerType,
                    text: vm.bannerTitle,
                    onDismiss: { vm.showBanner = false }
                )
            }
        }
    }
}

#Preview {
    MainScreenFactory()
}
