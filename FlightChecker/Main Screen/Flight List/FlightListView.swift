//
//  FlightListView.swift
//  FlightChecker
//
//  Created by Nikita Tsomuk on 15.05.2025.
//

import SwiftUI

struct FlightListView: View {
    
    @ObservedObject var vm: FlightViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.flights.self) { flightData in
                    FlightCell(flightData: flightData)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 15)
                        .padding(.horizontal, 16)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: vm.deleteFlight)
                .onMove(perform: vm.moveFlight)
                .compositingGroup()
                
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            
            Button {
                vm.updateAllFlights()
            } label: {
                AviaButtonLabel(title: "Update flight status", color: .primary)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 15)
        }
        .onAppear {
            vm.updateScreenState()
        }
    }
}

#Preview {
    FlightListView(vm: FlightViewModel())
}
