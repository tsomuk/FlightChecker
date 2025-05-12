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
        flightNumberForBanner = newFlightNumber
        Task {
            fetchFlightDetail(flightNumber: number)
        }
    }
    
    @MainActor
    func updateAllFlights() {
        screenState = .loading
        listOfFlights.removeAll()
        for flightNumber in listOfFlightsNumbers {
            fetchFlightDetail(flightNumber: flightNumber)
        }
    }
    
    @MainActor
    func fetchFlightDetail(flightNumber: String) {
        Task {
            do {
                let flightData = try await networkService.requestFlightDetail(code: flightNumber)
                
                if let newFlightData = flightData.data.first {
                    print(newFlightData)
                    withAnimation {
                        listOfFlights.append(newFlightData)
                        listOfFlightsNumbers.append(flightNumber)
                    }
                    
                    try await Task.sleep(for: .seconds(1.2))
                    showSuccessBanner()
                    updateScreenState()
                } else {
                    print("❌ NO DATA. END SEARCH")
                    try await Task.sleep(for: .seconds(1.2))
                    showErrorBanner()
                    updateScreenState()
                    return
                }
                
            } catch {
                showWarningBanner()
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
    }
}

extension FlightViewModel {
    func showSuccessBanner() {
        bannerType = .success
        bannerTitle = "Рейс \(flightNumberForBanner) добавлен!"
        showBanner = true
    }
    
    func showUpdateBanner() {
        bannerType = .success
        bannerTitle = "Данные по рейсам обновлены"
        showBanner = true
    }
    
    func showErrorBanner() {
        bannerType = .error
        bannerTitle = "Рейс \(flightNumberForBanner) не найден!"
        showBanner = true
    }
    
    func showWarningBanner() {
        bannerType = .warning
        bannerTitle = "Ошибка связи с сервером. Повторите попытку"
        showBanner = true
    }
}



/*
 struct TestDTO: Codable {
 let id: Int?
 let plane: PlaneDTO?
 let objects: [ObjectDTO]?
 
 struct ObjectDTO: Codable {
 let id: Int?
 let name: String?
 }
 
 struct PlaneDTO: Codable {
 let id: Int?
 let model: String?
 }
 }
 
 struct Test {
 let id: Int
 let objects: [Object]
 let planeId: Int
 let planeModel: String
 
 struct Object {
 let id: Int
 let name: String
 }
 }
 
 
 func mapTest(_ dto: TestDTO) throws -> Test {
 guard let id = dto.id,
 let plane = dto.plane,
 let planeID = plane.id else { throw NetworkError.invalidData }
 
 func mapObject(_ object: TestDTO.ObjectDTO) -> Test.Object {
 .init(
 id: object.id ?? 0,
 name: object.name ?? ""
 )
 }
 
 let objects = dto.objects?.compactMap { objectDTO in
 return mapObject(objectDTO)
 } ?? []
 
 return .init(
 id: id,
 objects: objects,
 planeId: planeID,
 planeModel: plane.model ?? ""
 )
 
 }
 
 */ //UI MODEL


//    Данные для верстки и тестов
//    @Published var listOfFlightsNumbers : [String] = ["fr269", "fr1215", "fr2357"]
//    @Published var listOfFlightsNumbers: [String] = ["6H881", "6H882", "6H821"]
//    @Published var listOfFlights: [FlightModel.FlightData] = [FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT]
