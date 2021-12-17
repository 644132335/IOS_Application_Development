//
//  durationPicker.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/19.
//

import SwiftUI

struct durationPicker: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        HStack{
            //picker for choose duration of the data to be graphed
            Spacer()
            Picker(selection:$manager.duration , label:Text("Duration")){
                ForEach(Duration.allCases, id: \.self){
                    Text($0.rawValue).tag($0)
                }
            }
            .onChange(of: manager.duration){ _ in
                // set graph data to be empty in order to have the graph redraw the correct graph
                manager.covidData = []
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


