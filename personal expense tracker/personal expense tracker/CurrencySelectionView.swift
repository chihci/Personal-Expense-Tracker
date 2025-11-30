//
//  CurrencySelectionView.swift
//  personal expense tracker
//
//  Created by 5433 on 11/29/25.
//

import SwiftUI

struct CurrencySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var converter: CurrencyConverter

    let currencies = ["USD","EUR","JPY","GBP","AUD","CAD","CHF","CNY","HKD"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(currencies, id: \.self) { currency in
                    HStack {
                        Text(currency)
                        Spacer()
                        if converter.selectedCurrency == currency {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        converter.selectedCurrency = currency
                        converter.fetchRates(base: currency)

                        dismiss()
                    }
                }
            }
            .navigationTitle("Choose Currency")
        }
        
    }
}


#Preview {
    CurrencySelectionView()
        .environmentObject(CurrencyConverter())
}
