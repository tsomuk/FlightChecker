//
//  FlightCardViewModel.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 09.10.2024.
//

import SwiftUI

enum ScreenState {
    case empty, loading, list
}

@MainActor
final class FlightViewModel: ObservableObject {
    //Services
    let networkService = NetworkService.shared
    // Banner variables
    @Published var showBanner = false
    @Published var bannerType: NotificationBannerType = .success
    @Published var bannerTitle: String = ""
    var flightNumberForBanner: String = ""
    // Flight variables
    @Published var newFlightNumber = ""
    @Published var showAddNewFlight = false
    @Published var screenState: ScreenState = .empty
    @Published var listOfFlights: [FlightModel.FlightData] = []
    @Published var listOfFlightsNumbers : [String] = []
    @Published var historyOfSearch: [String] = []

    func updateScreenState() {
        print("🔄 Screen update called 🔄")
        if listOfFlights.isEmpty {
            screenState = .empty
        } else {
            screenState = .list
        }
        flightNumberForBanner = ""
    @Published var flights: [FlightModel.FlightData] = []
    @Published var flightsNumbers : [String] = []
    }
    
    func addNewFlight(_ number: String) {
        screenState = .loading
        
        // Check is flight number already in history or not
        if !historyOfSearch.contains(newFlightNumber) && newFlightNumber.count > Constants.minFlightNumberLength {
            withAnimation {
                historyOfSearch.append(newFlightNumber)
            }
        }
        flightNumberForBanner = newFlightNumber
        
        if newFlightNumber.count > Constants.minFlightNumberLength {
            Task {
                fetchFlightDetail(flightNumber: number)
            }
        } else {
            showBanner(type: .error, title: "Номер рейса не может быть менее 2х символов")
            print(historyOfSearch.count)
        }
    }
   
    func updateAllFlights() {
        screenState = .loading
        flights.removeAll()
        for flightNumber in flightsNumbers {
            fetchFlightDetail(flightNumber: flightNumber, isUpdate: true)
        }
        
        Task {
            try await Task.sleep(for: .seconds(1.5))
            showBanner(type: .update, title: "Данные по рейсам обновлены")
        }
    }
    
    func fetchFlightDetail(flightNumber: String, isUpdate: Bool = false) {
        Task {
            do {
                let flightData = try await networkService.requestFlightDetail(code: flightNumber)
                
                if let newFlightData = flightData.data.first {
                    
                    withAnimation { flights.append(newFlightData) }
                    
                    // If update request - don't add flights again to lsit
                    if !isUpdate {
                        saveFlightToHistory(flightNumber)
                        try await Task.sleep(for: .seconds(1.2))
                        showBanner(type: .success, title: "Рейс \(flightNumberForBanner) добавлен!")
                    }
                } else {
                    print("❌ NO DATA. END SEARCH")
                    try await Task.sleep(for: .seconds(1.2))
                    showBanner(type: .error, title: "Рейс \(flightNumberForBanner) не найден!")
                    return
                }
            } catch {
                showBanner(type: .warning, title: "Ошибка связи с сервером. Повторите попытку")
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveHistory() {
        UserDefaults.standard.set(historyOfSearch, forKey: UDKeys.historyOfSearch)
    }

    private func updateScreenState() {
        print("🔄 Screen update called 🔄")
        if flights.isEmpty {
            screenState = .empty
        } else {
            screenState = .list
        }
        flightNumberForBanner = ""
    }
    
    private func saveFlightToHistory(_ flight: String) {
        flightsNumbers.append(flight)
    }
}

// MARK: - Functions for the move & delete list item
extension FlightViewModel {
    func moveFlight(from: IndexSet, to: Int) {
        flights.move(fromOffsets: from, toOffset: to)
        flightsNumbers.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteFlight(index: IndexSet) {
        withAnimation(.easeInOut(duration: 0.5)) {
            flights.remove(atOffsets: index)
            flightsNumbers.remove(atOffsets: index)
        }
        updateScreenState()
    }
}

// MARK: - Custom Banner
extension FlightViewModel {
    func showBanner(type: NotificationBannerType, title: String) {
        bannerType = type
        bannerTitle = title
        showBanner = true
        updateScreenState()
    }
}



//    Данные для верстки и тестов
//    @Published var listOfFlightsNumbers : [String] = ["fr269", "fr1215", "fr2357"]
//    @Published var listOfFlightsNumbers: [String] = ["6H881", "6H882", "6H821"]
//    @Published var listOfFlights: [FlightModel.FlightData] = [FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT]
//    @Published var historyOfSearch: [String] = ["AF123", "1H13", "AF623", "AF999", "AF623", "AF999"]
