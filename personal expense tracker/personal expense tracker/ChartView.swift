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
 
    let expenses: [ExpenseCategory] = expenseData
   var body: some View {
       ZStack{
           Chart(expenses) { item in
               SectorMark(
                   angle: .value("Amount", item.amount),
                   innerRadius: .ratio(0.6),
                   angularInset: 1.0
               )
               .foregroundStyle(by: .value("Category", item.name))
           }
           .chartLegend(position: .bottom, spacing: 10)
           .frame(height: 300)
           
           VStack(spacing: 4) {
                       Text("Amount Spent")
                           .font(.subheadline)
                           .foregroundColor(Color.primary)
                       Text("$6753")
                           .font(.title)
                           .bold()
                           .foregroundColor(Color.primary)
                   }
       }
   }
}


// MARK: - ExpenseBarChart
struct ExpenseBarChart: View {
    let expenses: [ExpenseCategory] = expenseData

    var body: some View {
        Chart(expenses) { item in
            BarMark(
                x: .value("Value", item.amount),
                y: .value("Category", item.name)
            )
            .cornerRadius(4)
            .foregroundStyle(by: .value("Category", item.name))

        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 250)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}


#Preview {
    ExpensePieChart()
    ExpenseBarChart()
}
