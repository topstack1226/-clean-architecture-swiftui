//
//  AppState.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var countries: Loadable<[Country]> = .notRequested
    var routing = ViewRouting() { willSet { self.objectWillChange.send() } }
    var system = System() { willSet { self.objectWillChange.send() } }
}

extension AppState {
    struct ViewRouting {
        var countriesList = CountriesList.Routing()
        var countryDetails = CountryDetails.Routing()
    }
}

extension AppState {
    struct System {
        var isActive: Bool = false
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        let state = AppState()
        state.countries = .loaded(Country.mockedData)
        return state
    }
}
#endif
