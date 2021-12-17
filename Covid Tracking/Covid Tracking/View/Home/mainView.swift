//
//  mainView.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/15.
//

import SwiftUI
import SwiftUICharts

struct mainView: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        
        NavigationView{
            ZStack{
            ScrollView{
                    VStack{
                        Spacer().frame(height: 10)
                        //picker area
                        HStack{
                            statePicker()
                            countyPicker()
                            Spacer()
                            durationPicker()
                        }
                        Spacer().frame(height: 10)
                        //graph area
                        dataChart().padding(2)
                        HStack{
                            Spacer()
                            Text("Last Updated "+manager.dateAgo(day: 1)).font(.subheadline).foregroundColor(Color.gray)
                            Spacer()
                        }
                        //data area
                        dataView()
                    }
            }
            }
            .toolbar(){
                // tool bar for refresh
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        Task{
                            await manager.refreshData()
                        }
                    }){Image(systemName: "arrow.clockwise")}}
            }
            
            .navigationTitle("HOME")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
}

