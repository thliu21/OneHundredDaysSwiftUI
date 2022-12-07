//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tianhao Liu on 12/5/22.
//

import Foundation
import Combine

class Order: ObservableObject {
    @Published var foodOrder = FoodOrder()
    @Published var address = Address()
    
    var cost: Double {
        // $2 per cake
        var cost = Double(foodOrder.quantity) * 2

        // $1/cake for extra frosting
        if foodOrder.extraFrosting {
            cost += Double(foodOrder.quantity)
        }

        // $0.50/cake for sprinkles
        if foodOrder.addSprinkles {
            cost += Double(foodOrder.quantity) / 2
        }

        return cost
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.Merge(foodOrder.objectWillChange, address.objectWillChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}

class FoodOrder: ObservableObject {
    enum CakeFlavor: String, CaseIterable {
        case vanilla = "Vanilla"
        case strawberry = "Strawberry"
        case chocolate = "Chocolate"
        case rainbow = "Rainbow"
        
        var id: RawValue {
            rawValue
        }
    }

    @Published var flavor: CakeFlavor = .vanilla
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}

class Address: ObservableObject {
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    @Published var isValid = false
    
    private var cancellable = Set<AnyCancellable>()
    
    private var nameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var streetAddressValidPublisher: AnyPublisher<Bool, Never> {
        $streetAddress
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var cityValidPublisher: AnyPublisher<Bool, Never> {
        $city
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var zipValidPublisher: AnyPublisher<Bool, Never> {
        $zip
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                $0.count == 5 && $0.isNumber
            }
            .eraseToAnyPublisher()
    }
    
    private var isAddressValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            nameValidPublisher,
            streetAddressValidPublisher,
            cityValidPublisher,
            zipValidPublisher
        )
        .map { $0 && $1 && $2 && $3 }
        .eraseToAnyPublisher()
    }
    
    init() {
        isAddressValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
    }
}

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
