//
//  ContentView.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager : CovidManager
   
    
    var body: some View {
        ZStack{
            // main view with 3 tabs
            TabView{
                mainView().tabItem{Label("Home", systemImage: "house")}
                StateView().tabItem{Label("State", systemImage: "globe.americas.fill")}
                countryView().tabItem{Label("Global", systemImage: "globe")}
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

