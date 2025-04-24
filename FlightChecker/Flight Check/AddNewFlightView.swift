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
        VStack(spacing: 15) {
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
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 30)
                    
                
              
                
                Button {
                    dismiss()
                    vm.addNewFlight(vm.newFlightNumber)
//                    vm.fetchFlightDetail(flightNumber: vm.newFlightNumber)
                    vm.newFlightNumber = ""
                } label: {
                    AviaButtonLabel(title: "ADD NEW FLIGHT", color: .white)
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .onAppear { isFocus = true }
//            .background(
//                Image(.plane)
//                    .resizable()
//                    .ignoresSafeArea()
//                    .opacity(0.7)
//                    .blur(radius: 0.7)
//            )
    }
}

#Preview {
    AddNewFlightView(vm: FlightViewModel())
}
