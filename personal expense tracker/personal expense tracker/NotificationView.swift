//
//  NotificationView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: "F5F7FA")
                    .ignoresSafeArea()
                VStack {
                
                    VStack(alignment:.leading) {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Saving Goal Reached!")
                                .font(.headline)
                        }
                        Spacer().frame(height: 10)
                        HStack {
                            Text("You have saved $1000 this month")
                                .font(.caption)
                            Spacer().frame(width: 90)
                            Text("2h ago")
                                .font(.caption)
                            
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                    .background(.white)
                    .cornerRadius(10)
                    
                    
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
}
