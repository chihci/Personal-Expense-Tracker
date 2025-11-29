//
//  DetailView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI
import Charts

struct DetailView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: "F5F7FA")
                 .ignoresSafeArea()
                
                VStack {
                    
                   ExpensePieChart()
                                    .padding()
                    
                   ExpenseBarChart()
                    NavigationLink(destination: GoalCategoriesView()) {
                        Text("Goals & Categories")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color(hex:"27AE60"))
                            .cornerRadius(10)
                        
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
    }
}

#Preview {
    DetailView()
}
