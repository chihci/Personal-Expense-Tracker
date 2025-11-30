//
//  AddAPaymentView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct AddAPaymentView: View {
    @EnvironmentObject var expenseData1: ExpenseFunction
    @EnvironmentObject var converter: CurrencyConverter
    @State private var activeError: ExpenseError?
    @State private var name = ""
    @State private var date = ""
    @State private var category = ""
    @State private var amount = ""
    @State private var notice = ""
    @State private var recurring = false
    @Environment(\.dismiss) private var dismiss//closez current view
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "F5F7FA")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer().frame(height: 20)
                    VStack(alignment: .leading, spacing: 16) {
                        CustomTextField(label: "Name", placeholder: "Enter payment name", text: $name)
                        CustomTextField(label: "Date", placeholder: "MM/DD/YYYY", text: $date)
                        CustomTextField(label: "Category", placeholder: "Enter category", text: $category)
                        
                        CustomTextField(label: "Amount", placeholder: "Enter amount", text: $amount)
                        
                       /* HStack {
                            Text("Recurring")
                                .font(.headline)
                            Spacer()
                            Toggle("", isOn: $recurring)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)*/
                        
                        CustomTextField(label: "Note", placeholder: "Optional note", text: $notice)
                    }
                    .padding(.horizontal)
                    
               
                    Button(action: {
                        //let amountValue = Double(amount)
                        guard let amountValue = Double(amount) else {
                                print("Invalid amount")
                            activeError = .invalidAmount
                                return
                            }
                        //let userAmount = Double(amount)
                        let amountInUSD = converter.convertToUSD(amount: amountValue, from: converter.selectedCurrency)
                        
                        expenseData1.addExpense(name: name, amount: amountInUSD, category: category, note: notice, eventdate: date)
                        dismiss()
                    }) {
                        Text("Add")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 30)
                            .background(Color(hex: "27AE60"))
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    
                    Spacer()
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .alert(item: $activeError) { error in
            Alert(
                title: Text("Invalid Amount"),
                message: Text(error.errorDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }

        
    }
    
    // MARK: - Textfield
    struct CustomTextField: View {
        let label: String
        let placeholder: String
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(label)
                    .font(.headline)
                    .foregroundColor(.black)
                TextField(placeholder, text: $text)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }

}

#Preview {
    AddAPaymentView()
        .environmentObject(ExpenseFunction())
}
