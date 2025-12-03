//
//  ChartView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/29/25.
//

import SwiftUI
import Charts
// MARK: - ExpensePieChart View
struct ExpensePieChart: View {
    @EnvironmentObject var expenseData1: ExpenseFunction
    @EnvironmentObject var converter: CurrencyConverter
   
   var body: some View {
       ZStack{
           if expenseData1.expense.isEmpty {
            Chart {
                SectorMark(
                 angle: .value("Amount", 1),
                 innerRadius: .ratio(0.6)
                        )
                  }
                  .foregroundStyle(Color.gray.opacity(0.3))
                  .frame(height: 300)
               
               VStack(spacing: 4) {
                   Text("Amount Spent")
                       .font(.subheadline)
                       .foregroundColor(Color.primary)
                   
                   Text("\(converter.format(amount: expenseData1.totalamount()))")
                       .font(.title2)
                       .foregroundColor(Color.primary)
               }
           }
           else
           {
               Chart(expenseData1.expense) { item in
                   SectorMark(
                       angle: .value("Amount", item.amount),
                       innerRadius: .ratio(0.6),
                       angularInset: 0.0
                   )
                   .foregroundStyle(expenseData1.colorForCategory(named: item.category))

               }
               .chartLegend(position: .bottom, spacing: 10)
               .frame(height: 300)
               
               VStack(spacing: 4) {
                   Text("Amount Spent")
                       .font(.subheadline)
                       .foregroundColor(Color.primary)
                   
                   Text("\(converter.format(amount: expenseData1.totalamount()))")
                       .font(.title2)
                       .foregroundColor(Color.primary)
                   //Spacer().frame(height: 0)
               }

           }
       }
   }
    
   

}


// MARK: - ExpenseBarChart
struct ExpenseBarChart: View {
    let expenses: [ExpenseCategory] = expenseData
    @EnvironmentObject var expenseData1: ExpenseFunction
    @EnvironmentObject var converter: CurrencyConverter
    var body: some View {
        Chart(expenseData1.expense) { item in
            BarMark(
                x: .value("Value", converter.convertFromUSD(amount: item.amount, to: converter.selectedCurrency)),

                y: .value("Category", item.category)
            )
            .cornerRadius(4)
            .foregroundStyle(expenseData1.colorForCategory(named: item.category))

        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 250)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .overlay {
                    if expenseData1.expense.isEmpty {
                        ContentUnavailableView(
                            "No Data Yet",
                            systemImage: "chart.bar.yaxis",
                            description: Text("Add your first expense to see your chart.")
                        )
                    }
                }
    }
    
    

}


#Preview {
    ExpensePieChart()
        .environmentObject(ExpenseFunction())
        .environmentObject(CurrencyConverter())
    ExpenseBarChart()
        .environmentObject(ExpenseFunction())
        .environmentObject(CurrencyConverter())
}
