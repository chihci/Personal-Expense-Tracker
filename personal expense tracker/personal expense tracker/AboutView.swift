//
//  AboutView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: "F5F7FA")
                 .ignoresSafeArea()
                
                VStack {

                    Spacer().frame(height: 20)
                    
                    VStack{
                        Spacer().frame(height: 140)
                        Image(systemName: "receipt")
                            .resizable()
                            .frame(width: 100, height: 130)
                            .font(.system(size: 100, weight: .thin))
                        Spacer().frame(height: 30)
                        Text("Personal Expense Tracker")
                        Spacer().frame(height: 10)
                        Text("Track your spending and achieve your saving goals.")
                            .font(.footnote
                                )
                            .foregroundStyle(.secondary)
                        
                        Spacer().frame(height: 150)
                        HStack{
                            VStack(alignment: .leading){
                                Text("Created by: Runfeng Xiao")
                                Text("Contact: rxiao4@cougarnet.uh.edu")
                                Text("Version: v1.0")
                            }
                            Spacer().frame(width: 60)
                        }
                            
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    AboutView()
}
