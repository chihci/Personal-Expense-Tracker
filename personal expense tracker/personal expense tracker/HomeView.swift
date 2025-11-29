//
//  HomeView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    
    @EnvironmentObject var expenseData1: ExpenseFunction
    
    var body: some View {
            NavigationStack{
                ZStack{
                    Color(hex: "F5F7FA")
                     .ignoresSafeArea()
                    
                    VStack{//for whole page
                        VStack{//for upper part
                            //Spacer().frame(height: 70)
                            HStack{
                                Text("Monthly Summary")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                Spacer().frame(width: 130)
                                NavigationLink(destination:TestCurrencyView()){Text("test currency")}
                                NavigationLink(destination: DetailView()){
                                    Text("Details")
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 17)
                                        .background(Color(hex:"27AE60"))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                            }
                            //.padding(.top, 50)
                            //.padding(.horizontal)
                            
                            ExpensePieChart()
                               .padding()
                            
                        }
                        //.padding(.top, 50)
                        //.padding(.bottom, 10)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white) // card background color
                                .ignoresSafeArea(edges: .top)
                        )
                        .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 3)
                        /*.padding(.top, 100)
                         .padding(.bottom,10)
                         // .background(Color(hex: "2C3E50")).ignoresSafeArea()
                         .cornerRadius(20)*/
                        
                        
                        Spacer().frame(height: 20)
                        HStack{
                            Text("Spending History")
                                .foregroundColor(.black)
                                .font(.headline)
                            Spacer().frame(width: 150)
                            NavigationLink(destination: HistoryView()){
                                Text("View")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 17)
                                    .background(Color(hex:"27AE60"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        }
                       
                        
                        HomeHistory()
                        
                       
                        
                      // Spacer().frame(height: 200)
                        
                    }
            
                }
            }
    }
    

}

// MARK: - ExpensePieChart View
struct HomeHistory: View {
    
    @EnvironmentObject var expenseData1: ExpenseFunction
    
    var body: some View {
       List{
            ForEach(expenseData1.expense) { item in
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(item.amount)")
                        .font(.headline)
                        .foregroundColor(Color(hex: "ED3F27"))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
            }
        }
       .overlay {
           if expenseData1.expense.isEmpty {
               VStack(spacing: 16) {
                   ContentUnavailableView(
                       "No Spending Yet",
                       systemImage: "pencil.and.list.clipboard",
                       description: Text("Add your first spending inside Spending History!")
                   )
                   Spacer().frame(height: 40)

                   NavigationLink(destination: AddAPaymentView()) {
                       Text("Add here")
                           .padding(.vertical, 10)
                           .padding(.horizontal, 17)
                           .background(Color(hex:"27AE60"))
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
               }
               .padding(.top, 40) // optional: adjust vertical position
           }
       }

       /*.overlay {
           if expenseData1.expense.isEmpty {
               ContentUnavailableView("No Spending Yet", systemImage: "pencil.and.list.clipboard", description: Text("Add your first spending inside Spending hisory!"))
               NavigationLink(destination: AddAPaymentView()){
                   Text("Add here")
                       .padding(.vertical, 10)
                       .padding(.horizontal, 17)
                       .background(Color(hex:"27AE60"))
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
           }
       }*/
    }
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
    
    return HomeView()
        .environmentObject(mock)
    
}


