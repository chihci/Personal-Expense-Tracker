//
//  testcurrency.swift
//  personal expense tracker
//
//  Created by 5433 on 11/29/25.
//

import SwiftUI

struct TestCurrencyView: View {
    @EnvironmentObject var converter: CurrencyConverter
    @State private var amount = "100"
    @State private var result = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            Button("Convert USD → EUR") {
                if let value = Double(amount),
                   let converted = converter.convert(amount: value, from: "USD", to: "EUR") {
                    result = String(format: "%.2f EUR", converted)
                }
            }
            
            Text(result)
                .font(.title)
        }
        .onAppear {
            converter.fetchRates()
        }
    }
}



#Preview {
    TestCurrencyView()
        .environmentObject(CurrencyConverter())
}
