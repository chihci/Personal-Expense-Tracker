//
//  NotificationView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct NotificationView: View {
    
    @EnvironmentObject var expenseData1: ExpenseFunction
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: "F5F7FA")
                    .ignoresSafeArea()
                
                
                VStack {
                    List {
                        ForEach(Array(expenseData1.messages.enumerated()), id: \.element.id) { index, message in
                            
                            VStack(alignment: .leading) {
                              
                                    HStack {
                                        Image(systemName: message.imageString)
                                        Text(message.title)
                                            .font(.headline)
                                    }
                                    
                                    Spacer().frame(height: 10)
                                    
                                    HStack {
                                        Text(message.body)
                                            .font(.caption)
                                        Spacer().frame(width: 90)
                                        Text(message.date)
                                            .font(.caption)
                                    }
                                
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .background(.white)
                            .cornerRadius(10)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        expenseData1.removeNotification(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .overlay {
                        if expenseData1.messages.isEmpty {
                            ContentUnavailableView("You don't have message yet.", systemImage: "envelope.open.fill", description: Text("Good, you did not have any overspending..."))
                        }
                    }



                    Spacer()
                    
                }
            }
            .navigationTitle(Text("Notification"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }

    }
}

#Preview {
    NotificationView()
        .environmentObject(ExpenseFunction())
}
