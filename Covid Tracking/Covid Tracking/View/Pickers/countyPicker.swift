//
//  countyPicker.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/22.
//

import SwiftUI

struct countyPicker: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        HStack{
            //picker to choose county
            Spacer().frame(width: 10)
            Picker(selection:$manager.county , label:Text("County")){
                ForEach(manager.usCounties, id: \.self){
                    Text($0).tag($0)
                }
            }
            .onChange(of: manager.county){ _ in
                // set graph data to be empty in order to have the graph redraw the correct graph
                manager.covidData=[]
                Task{
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

