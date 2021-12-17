//
//  dataChart.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/17.
//

import SwiftUI
import SwiftUICharts

struct dataChart: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        VStack{
            // calling the dependency and graph the data
            BarChartView(data: ChartData(values: manager.covidData), title: "Covid Cases", legend: "Last 7 Days",style: Styles.barChartStyleNeonBlueLight, form: ChartForm.extraLarge, dropShadow: true, valueSpecifier: "%.0f cases")
            
        }
       
        
    }
}

