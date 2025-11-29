//
//  API service.swift
//  personal expense tracker
//
//  Created by 5433 on 11/29/25.
//

import Foundation

struct CurrencyResponse: Codable {
    let data: [String: Double]
}



class CurrencyConverter: ObservableObject {
    @Published var rates: [String: Double] = [:]
    
    private let apiKey = "fca_live_kXr9u6RPCXDNh8pkVI3CSJ2VJr3F10kPJHPaQNq7"
    
    func fetchRates(base: String = "USD") {
        let urlString = "https://api.freecurrencyapi.com/v1/latest?apikey=\(apiKey)&base_currency=\(base)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                DispatchQueue.main.async {
                    self.rates = decoded.data
                }
            } catch {
                print("Decode error:", error)
            }
        }.resume()
    }
    
    /// Converts amount from one currency to another
    func convert(amount: Double, from base: String, to target: String) -> Double? {
        guard let baseRate = rates[base.uppercased()],
              let targetRate = rates[target.uppercased()] else {
            return nil
        }
        
        // USD-based conversion:
        // base → USD → target
        let usdAmount = amount / baseRate
        return usdAmount * targetRate
    }
}
