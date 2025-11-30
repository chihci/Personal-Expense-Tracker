//
//  API service.swift
//  personal expense tracker
//
//  Created by 5433 on 11/29/25.
//

import Foundation
import SwiftUI




class CurrencyConverter: ObservableObject {
    
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD" {
        didSet { /* no fetch here! */ }
    }


    @Published var rates: [String: Double] = [:]

    private let apiKey = "fca_live_kXr9u6RPCXDNh8pkVI3CSJ2VJr3F10kPJHPaQNq7"

    init() {
        fetchRates(base: "USD")
    }

    func fetchRates(base: String) {
        let urlString = "https://api.freecurrencyapi.com/v1/latest?apikey=\(apiKey)&base_currency=USD"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }

            if let decoded = try? JSONDecoder().decode(CurrencyResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.rates = decoded.data
                }
            }
        }.resume()
    }
    
    func convertToUSD(amount: Double, from currency: String) -> Double {
        guard let rate = rates[currency] else { return amount }
        return amount / rate
    }
    
    func convertFromUSD(amount: Double, to target: String) -> Double {//(USD) → selectedCurrency for display
        guard let rate = rates[target] else { return amount }
        return amount * rate
    }
    
   

    // format converted amount
    func format(amount: Double) -> String {
        let target = selectedCurrency.uppercased()
        let converted = convertFromUSD(amount: amount, to: target)

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = target

        return formatter.string(from: NSNumber(value: converted)) ?? "\(converted)"
    }

}

