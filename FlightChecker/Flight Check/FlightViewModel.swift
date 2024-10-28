//
//  FlightCardViewModel.swift
//  Metar_SwiftUI
//
//  Created by Nikita Tsomuk on 09.10.2024.
//

import SwiftUI

enum ScreenState {
   case empty, loading, list, error
}

final class FlightViewModel: ObservableObject {
    
    let networkService = NetworkService.shared
    
    @Published var newFlightNumber = ""
    @Published var showAddNewFlight = false
    //    @Published var isShowingLoader = false
    @Published var listOfFlightsNumbers : [String] = []
    @Published var listOfFlights: [FlightModel.FlightData] = []
    @Published var screenState: ScreenState = .empty
    
    
    //    Данные для верстки и тестов
    //    @Published var listOfFlightsNumbers: [String] = ["6H881", "6H882", "6H821"]
    //        @Published var listOfFlights: [FlightModel.FlightData] = [FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT, FlightModel.MOCK_FlIGHT]
    
    
    func addNewFlight(_ number: String) {
        listOfFlightsNumbers.append(number)
        fetchFlightDetail()
    }
    
    func moveFlight(from: IndexSet, to: Int) {
        listOfFlights.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteFlight(index: IndexSet) {
        withAnimation(.easeInOut(duration: 0.5)) {
            listOfFlights.remove(atOffsets: index)
        }
    }
    
    func updateScreenState() {
        if listOfFlights.isEmpty {
            screenState = .empty
        } else {
            screenState = .list
        }
    }
    
    func updateAllFlights() {
        
    }
    
    func fetchFlightDetail() {
        screenState = .loading
        listOfFlights.removeAll()
        Task { @MainActor in
            for flightNumber in listOfFlightsNumbers {
                do {
                    let flightJsonData = try await networkService.requestFlightDetail(code: flightNumber)
                    if let flight = flightJsonData.data.first {
                        listOfFlights.append(flight)
                        
                    } else {
                        // show some notification "No data for flight"
                    }
                    updateScreenState()
                } catch {
                    print(error.localizedDescription)
                    screenState = .error
                    print("ошибка")
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //                        self.screenState =
                    //                        print("нет ошибки")
                    //                    }
                }
                //            updateScreenState()
            }
        }
    }
    
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
}
