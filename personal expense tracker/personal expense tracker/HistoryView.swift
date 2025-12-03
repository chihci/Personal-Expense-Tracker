//
//  HistoryView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var expenseData1: ExpenseFunction
    @EnvironmentObject var converter: CurrencyConverter
    
    
    
    @State var removeExpense: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "F5F7FA")
                    .ignoresSafeArea()

                VStack(spacing: 12) {

                    HStack(spacing: 10) {
                        Spacer()

                        filterButton(title: "By Date", filter: .date)
                        filterButton(title: "By Category", filter: .category)
                        filterButton(title: "By Amount", filter: .amount)


                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)

                    List { 
                        ForEach(expenseData1.sortedExpenses) { item in
                            HStack(alignment: .top, spacing: 10) {
                                if removeExpense {
                                                Button(action: {
                                                    if let index = expenseData1.expense.firstIndex(where: { $0.id == item.id }) {
                                                        expenseData1.removeExpense(at: IndexSet(integer: index))
                                                    }
                                                }) {
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.red)
                                                        .padding(.trailing, 8)
                                                }
                                            }
                                Rectangle()
                                    .fill(expenseData1.colorForCategory(named: item.category))

                                    .frame(width: 3)
                                    .cornerRadius(1)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.category)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(item.name)
                                        .font(.headline)
                                    if !item.note.isEmpty {
                                        Text(item.note)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }

                                Spacer()
                               
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(item.category == "Income" ? "+\(converter.format(amount: item.amount))" : "-\(converter.format(amount: item.amount))")
                                        .font(.headline)
                                        .foregroundColor(item.category == "Income" ? .green : .red)
                                    Text(item.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                        
                       
                    }
                    .listStyle(.plain)
                    .overlay {
                        if expenseData1.expense.isEmpty {
                            ContentUnavailableView("You don't have spending yet.", systemImage: "square.and.pencil", description: Text("Add a spending to get started."))
                        }
                    }

                    
                    HStack(spacing: 15) {
                        Button(action: {
                            removeExpense.toggle()
                        }) {
                            Text("Remove a Spending")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color(hex: "ED3F27"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: AddAPaymentView()) {
                         Text("Add a Spending")
                             .font(.caption)
                             .fontWeight(.bold)
                             .padding(.vertical, 10)
                             .padding(.horizontal, 20)
                             .background(Color(hex: "27AE60"))
                             .foregroundColor(.white)
                             .cornerRadius(10)
                        }

                    }
                    Spacer()
                    if expenseData1.showBanner {
                                   BannerMessage(
                                       title: expenseData1.bannerTitle,
                                       message: expenseData1.bannerMessage
                                   )
                                   .transition(.move(edge: .top).combined(with: .opacity))
                                   .zIndex(10)
                                   .padding(.top, 10)
                               }
                }
               
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
    @ViewBuilder
    func filterButton(title: String, filter: HistoryFilter)
 -> some View {
        Text(title)
            .font(.caption)
            .fontWeight(expenseData1.selectedFilter == filter ? .bold : .medium)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(expenseData1.selectedFilter == filter ? Color(hex: "27AE60") : .white)
            .foregroundColor(expenseData1.selectedFilter == filter ? .white : .black)
            .cornerRadius(8)
            .onTapGesture {
                expenseData1.selectedFilter = filter
            }
    }

    /*func colorFor(item: ExpenseItem) -> Color {
        if let cat = expenseData1.category.first(where: { $0.catname == item.category }) {
            return Color(hex: cat.colorHex)
        }
        return .gray   // fallback color
    }*/
    
    
    


}

#Preview {
    let mock = ExpenseFunction()
    mock.expense = [
        ExpenseItem(
            name: "Food",
            amount: 100,
            date: "Today",
            category: "Food",
            note: "",
            eventdate: "",
            categoryID: UUID()
        ),
        ExpenseItem(
            name: "Food",
            amount: 100,
            date: "Today",
            category: "Food",
            note: "",
            eventdate: "",
            categoryID: UUID()
        )
        ,
        ExpenseItem(
            name: "Food",
            amount: 100,
            date: "Today",
            category: "Food",
            note: "",
            eventdate: "",
            categoryID: UUID()
        ),
        ExpenseItem(
            name: "Food",
            amount: 100,
            date: "Today",
            category: "Food",
            note: "",
            eventdate: "",
            categoryID: UUID()
        )
    ]
    
    return HistoryView()
        .environmentObject(mock)//it just tells the preview canvas what example data to use when rendering your view.
        .environmentObject(CurrencyConverter())
}
