//
//  statePicker.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/22.
//

import SwiftUI

struct statePicker: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        HStack{
            //picker for choose state
            Spacer().frame(width: 10)
            Picker("States",selection:$manager.state){
                ForEach(manager.usStates, id: \.self){i in
                    Text(i)
                }
            }
            .onChange(of: manager.state){ _ in
                
                // set graph data to be empty in order to have the graph redraw the correct graph
                manager.covidData=[]
                Task{
                    //get list of counties that belongs to the state
                    await manager.getCounty(state: manager.state)
                    await manager.refreshData()
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 17).fill(Color.white))
            .shadow(radius: 6)
            Spacer().frame(width: 10)
        }
    }
}


