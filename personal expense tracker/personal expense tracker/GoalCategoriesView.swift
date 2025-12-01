//
//  GoalCategoriesView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct GoalCategoriesView: View {
    @State private var selectedColor: Color = .blue
    let expenses: [ExpenseCategory] = expenseData
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var removeCategories: Bool = false
    
    @EnvironmentObject var expenseData1: ExpenseFunction
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: "F5F7FA")
                    .ignoresSafeArea()
                VStack {
                    
                    List {
                        ForEach(expenseData1.category){item in
                            HStack {
                                
                                if removeCategories {
                                 Button(action: {
                                     if let index = expenseData1.category.firstIndex(where: { $0.id == item.id }) {
                                         expenseData1.removeCategory(at: IndexSet(integer: index))
                                     }
                                 }) {
                                     Image(systemName: "trash")
                                         .foregroundColor(.red)
                                         .padding(.trailing, 8)
                                 }
                             }
                                
                                
                                Text(item.catname)
                                    .font(.caption)
                                    .foregroundColor(Color(hex: item.colorHex))
                                
                                Spacer()
                                Text("Goal: \(Int(item.target))$")
                                    .font(.headline)
                                
                            }
                            .padding(.vertical)
                        }
                       
                        
                    }
                    .listStyle(.plain)
                    
                    HStack{
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Enter  amount", text: $amount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        ColorPicker("", selection: $selectedColor, supportsOpacity: false)
                            .labelsHidden()
                            .scaleEffect(0.9)
                            .padding(.trailing, 0)          
                            .frame(width: 28, height: 28)
                    }
                    .padding(.horizontal, 10)
                    HStack{
                        
                        Button(action: {
                            removeCategories.toggle()
                            //removeCategory
                        })
                        {
                               Text("Remove a Categorie")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 14)
                                .background(Color(hex: "ED3F27"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                         guard let targetInt = Int(amount) else {
                             print("Invalid target number")
                             return
                         }

                            expenseData1.addCategory(
                             catname: name,
                             color: selectedColor,
                             target: targetInt
                         )

                         name = ""
                         amount = ""
                         selectedColor = .blue

                     }) {
                         Text("Add a Category")
                             .font(.caption)
                             .fontWeight(.bold)
                             .padding(.vertical, 10)
                             .padding(.horizontal, 20)
                             .background(Color(hex: "27AE60"))
                             .foregroundColor(.white)
                             .cornerRadius(10)
                     }

                        
                        
                        
                    }
                    
                    Spacer().frame(height: 50)
                }
                
            }
            .navigationTitle("Goals & Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }

    }
    
}


#Preview {
    GoalCategoriesView()
        .environmentObject(ExpenseFunction())
}
