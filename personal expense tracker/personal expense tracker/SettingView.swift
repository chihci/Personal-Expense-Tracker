//
//  SettingView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                Color(hex: "F5F7FA")
                 .ignoresSafeArea()
                
                VStack {
                   
                    
                    VStack(alignment: .leading){
                        Spacer().frame(height: 20)
                        Text("Preferences")
                            .font(.headline)
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                            Text("Currency Conversion")
                            Spacer()
                            Text("USD >")
                                .foregroundStyle(Color(hex:"27AE60"))
                            Spacer().frame(width: 18)
                        }
                        .frame(width: 350)
                        .padding(.vertical, 10)
                        .background(.white)
                        .cornerRadius(10)
                       
                        
                        Text("Notifications")
                            .font(.headline)
                            .fontWeight(.bold)
                        VStack{
                            HStack {
                                Image(systemName: "exclamationmark.triangle")
                                Text("Budget Alerts")
                                Spacer()
                                Text("OFF")
                                    .foregroundStyle(Color(hex:"27AE60"))
                                Spacer().frame(width: 18)
                            }
                            .frame(width: 350)
                            .padding(.vertical, 10)
                            .background(.white)
                            .cornerRadius(10)
                            
                            HStack {
                                Image(systemName: "checkmark.bubble")
                                Text("Goal Reminders")
                                Spacer()
                                Text("ON")
                                    .foregroundStyle(Color(hex:"27AE60"))
                                Spacer().frame(width: 18)
                            }
                            .frame(width: 350)
                            .padding(.vertical, 10)
                            .background(.white)
                            .cornerRadius(10)
                        }
                        
                        
                        Text("About this app")
                            .font(.headline)
                            .fontWeight(.bold)
                        NavigationLink(destination: AboutView()) {
                            HStack {
                                Image(systemName: "exclamationmark.circle")
                                Text("App Info")
                                Spacer()
                            }
                            .frame(width: 350)
                            .padding(.vertical, 10)
                            .background(.white)
                            .cornerRadius(10)
                        }
                        Spacer()
                    }

                }
            }
            .navigationTitle(Text("Setting"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(hex:"2C3E50"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)

        }
        
    }
}

#Preview {
    SettingView()
}
