//
//  dataView.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/19.
//

import SwiftUI
import SwiftUICharts

struct dataView: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        
        // view to display the data
        VStack{
            dataBox(text: "Confirmed Today ", data: manager.todayInfo.confirmed_daily,dataColor: Color.orange).padding(5)
            dataBox(text: "Confirmed Total ", data: manager.todayInfo.confirmed,dataColor: Color.orange).padding(5)
            dataBox(text: "Death Today ", data: manager.todayInfo.deaths_daily,dataColor: Color.red).padding(5)
            dataBox(text: "Death Total ", data: manager.todayInfo.deaths, dataColor: Color.red).padding(5)
            dataBox(text: "Population", data: manager.todayInfo.population ?? 0, dataColor: Colors.BorderBlue).padding(5)
        }
    }
}


