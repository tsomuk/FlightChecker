//
//  AddNewFlightView.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 09.10.2024.
//

import SwiftUI

struct AddNewFlightView: View {
    
    @ObservedObject var vm: FlightViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocus: Bool
    
    enum Focus { case newFlight }
    
    var body: some View {
        VStack(spacing: 20) {
            textField
            
            if !vm.listOfFlightsNumbers.isEmpty {
                RecentFactory(recentFlight: vm.listOfFlightsNumbers, cleanHistoryAction: cleanHistoryButtonTapped)
            }
            
            addFlightButton
            }
            .padding(.horizontal)
            .onAppear { isFocus = true }
    }
    
    private var textField: some View {
        TextField("Flight number", text: $vm.newFlightNumber)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.characters)
            .textCase(.uppercase)
            .keyboardType(.webSearch)
            .tint(.primary)
            .padding()
            .focused($isFocus)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.8)
                    .foregroundStyle(.primary)
            }
    }
    
    
    private var addFlightButton: some View {
        Button {
            vm.addNewFlight(vm.newFlightNumber)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dismiss()
            }
//                    vm.fetchFlightDetail(flightNumber: vm.newFlightNumber)
            vm.newFlightNumber = ""
        } label: {
            AviaButtonLabel(title: "ADD NEW FLIGHT", color: .primary)
        }
    }
    
    private func cleanHistoryButtonTapped() {
        vm.listOfFlightsNumbers.removeAll()
    }
}

#Preview {
    AddNewFlightView(vm: FlightViewModel())
}
