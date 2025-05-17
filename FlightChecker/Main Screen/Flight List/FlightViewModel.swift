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

final class FlightViewModel: ObservableObject {
    
    let networkService = NetworkService.shared
    
    @Published var showBanner = false
    @Published var bannerType: NotificationBannerType = .success
    @Published var bannerTitle: String = ""
    
    @Published var newFlightNumber = ""
    @Published var showAddNewFlight = false
    @Published var screenState: ScreenState = .empty
    @Published var listOfFlights: [FlightModel.FlightData] = []
    @Published var listOfFlightsNumbers : [String] = []
    @Published var historyOfSearch: [String] = []
    //    @Published var historyOfSearch: [String] = ["AF123", "1H13", "AF623", "AF999", "AF623", "AF999"]
    
    var flightNumberForBanner: String = ""
    
    @MainActor
    func updateScreenState() {
        print("🔄 Screen update called 🔄")
        if listOfFlights.isEmpty {
            screenState = .empty
        } else {
            screenState = .list
        }
        flightNumberForBanner = ""
    }
    
    @MainActor
    func addNewFlight(_ number: String) {
        screenState = .loading
        
        // Check is flight number already in history or not
        if !historyOfSearch.contains(newFlightNumber) && newFlightNumber.count > 2 {
            withAnimation {
                historyOfSearch.append(newFlightNumber)
            }
        }
        flightNumberForBanner = newFlightNumber
        
        if newFlightNumber.count > 3 {
            Task {
                fetchFlightDetail(flightNumber: number)
            }
        } else {
            showBanner(type: .error, title: "Номер рейса не может быть менее 3х символов")
            print(historyOfSearch.count)
            updateScreenState()
        }
    }
    
    @MainActor
    func updateAllFlights() {
        screenState = .loading
        listOfFlights.removeAll()
        for flightNumber in listOfFlightsNumbers {
            fetchFlightDetail(flightNumber: flightNumber, isUpdate: true)
        }
    }
    
    @MainActor
    func fetchFlightDetail(flightNumber: String, isUpdate: Bool = false) {
        Task {
            do {
                let flightData = try await networkService.requestFlightDetail(code: flightNumber)
                
                if let newFlightData = flightData.data.first {
//                    print(newFlightData)
                    
                    // If update request - don't add flights again to lsit
                    
                    withAnimation {
                        listOfFlights.append(newFlightData)
                    }
                    
                    if !isUpdate {
                        listOfFlightsNumbers.append(flightNumber)
                    }
                    
                    try await Task.sleep(for: .seconds(1.2))
                    showBanner(type: .success, title: "Рейс \(flightNumberForBanner) добавлен!")
                    updateScreenState()
                } else {
                    print("❌ NO DATA. END SEARCH")
                    try await Task.sleep(for: .seconds(1.2))
                    showBanner(type: .error, title: "Рейс \(flightNumberForBanner) не найден!")
                    updateScreenState()
                    return
                }
                
            } catch {
                showBanner(type: .warning, title: "Ошибка связи с сервером. Повторите попытку")
                updateScreenState()
                print(error.localizedDescription)
            }
        }
        
    }
}

extension FlightViewModel {
    // MARK: - FUNC FOR THE LIST
    func moveFlight(from: IndexSet, to: Int) {
        listOfFlights.move(fromOffsets: from, toOffset: to)
        listOfFlightsNumbers.move(fromOffsets: from, toOffset: to)
    }
    
    @MainActor
    func deleteFlight(index: IndexSet) {
        withAnimation(.easeInOut(duration: 0.5)) {
            listOfFlights.remove(atOffsets: index)
            listOfFlightsNumbers.remove(atOffsets: index)
        }
        updateScreenState()
    }
}

extension FlightViewModel {
    func showBanner(type: NotificationBannerType, title: String) {
        bannerType = type
        bannerTitle = title
        showBanner = true
    }
}



//    Данные для верстки и тестов
//    @Published var listOfFlightsNumbers : [String] = ["fr269", "fr1215", "fr2357"]
//    @Published var listOfFlightsNumbers: [String] = ["6H881", "6H882", "6H821"]
//    @Published var listOfFlights: [FlightModel.FlightData] = [FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT]
