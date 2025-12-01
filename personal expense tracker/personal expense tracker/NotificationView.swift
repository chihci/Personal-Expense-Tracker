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
                ForEach(expenseData1.notification_messages, id: \.self) { message in
                    VStack(alignment:.leading) {
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
