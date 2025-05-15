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
        
    var body: some View {
        VStack(spacing: 12) {
            textField
                .padding(.top,15)
            
            recentSearchesSection
            
            addFlightButton
                .padding(.bottom, 10)
            Spacer()
            
            }
        .padding([.top, .horizontal])
    }
    
    private var textField: some View {
        TextField("Flight number", text: $vm.newFlightNumber)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.characters)
            .textCase(.uppercase)
            .keyboardType(.webSearch)
            .tint(.primary)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.8)
                    .foregroundStyle(.primary)
            }
    }
    
    private var recentSearchesSection: some View {
        Group {
            if !vm.historyOfSearch.isEmpty {
                RecentFactory(recentFlight: vm.historyOfSearch, cleanHistoryAction: cleanHistoryButtonTapped)
            }
        }
    }
    
    private var addFlightButton: some View {
        Button {
            vm.addNewFlight(vm.newFlightNumber)
            vm.newFlightNumber = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                dismiss()
            }
        } label: {
            AviaButtonLabel(title: "Add new flight", color: .primary)
        }
    }
    
    private func cleanHistoryButtonTapped() {
        withAnimation {
            vm.historyOfSearch.removeAll()
        }
    }
}

#Preview {
    AddNewFlightView(vm: FlightViewModel())
        .frame(height: 235)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
}
