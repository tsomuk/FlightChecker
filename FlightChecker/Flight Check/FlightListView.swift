//
//  FlightCardListView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 30.09.2024.
//

import SwiftUI

struct FlightListView: View {
    
    @StateObject var vm = FlightViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch vm.screenState {
                case .empty:
                    EmptyListView()
                case .loading:
                    ProgressView().scaleEffect(2)
                case .list:
                    listWithButton
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
                    ToolbarItem(placement: .topBarLeading) { EditButton()
                            .tint(.primary)
                    }
                }
                .sheet(isPresented: $vm.showAddNewFlight) {
                    AddNewFlightView(vm: vm)
                        .presentationDetents([.height(120)])
                }
        } .onAppear {
            vm.updateScreenState()
        }
    }
    
    private var listWithButton: some View {
        VStack {
            List {
                ForEach(vm.listOfFlights.self) { flightData in
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
                AviaButtonLabel(title: "UPDATE FLIGHTS STATUS", color: .primary)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 15)
        }

    }
}

#Preview {
    FlightListView()
}
