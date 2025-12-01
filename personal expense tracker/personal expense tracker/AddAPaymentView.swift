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
    @State private var selectedCategory: categoryData?

    //@State private var category = ""
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
                      
                        CatPicker(selectedCategory: $selectedCategory)
                        
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
                        guard let amountValue = Double(amount) else {
                            activeError = .invalidAmount
                            return
                        }

                        // Convert currency
                        let amountInUSD = converter.convertToUSD(amount: amountValue, from: converter.selectedCurrency)
                        guard let cat = selectedCategory else {
                            print("No category selected")
                            return
                        }


                        // Add expense using the category name
                        expenseData1.addExpense(
                            name: name,
                            amount: amountInUSD,
                            category: cat.catname,
                            note: notice,
                            eventdate: date
                        )

                        // Notification based on full categoryData (correct)
                        expenseData1.checkNotification(for: cat, newAmount: amountInUSD)

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

// MARK: - catdropdown
struct CatPicker: View {
    @EnvironmentObject var expenseData1: ExpenseFunction
    @Binding var selectedCategory: categoryData?

    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(expenseData1.category) { cat in
                HStack {
                    Circle()
                        .fill(Color(hex: cat.colorHex))
                        .frame(width: 12, height: 12)
                    Text(cat.catname)
                }
                .tag(Optional(cat))
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}



#Preview {
    AddAPaymentView()
        .environmentObject(ExpenseFunction())
}
