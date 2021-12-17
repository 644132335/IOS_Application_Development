//
//  StateDetailView.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/12/9.
//

import SwiftUI
import SwiftUICharts

struct StateDetailView: View {
    @Binding var state : StateInfo
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    // get the data and calculate them for later display
                    let population = state.population ?? 1
                    let confirm = state.confirmed ?? 1
                    let unconfirm = population-confirm
                    let confirm_rate = (Double(confirm)/Double(population))*100
                    let unconfirm_rate = (Double(unconfirm)/Double(population))*100

                    Spacer().frame(height: 10)
                    //use the pie chart view to graph the confirmed vs unconfirmed
                    PieChartView(data: [Double(state.confirmed ?? 0), Double(unconfirm)], title: "Confirmed VS Unconfirmed", legend: "   Confirmed: \(Int(confirm_rate.rounded()))%     Unconfirmed: \(Int(unconfirm_rate.rounded()))%", style: Styles.barChartStyleNeonBlueLight,form: ChartForm.extraLarge, dropShadow: true, valueSpecifier: "%.0f People").padding(10)
                    VStack{
                        HStack{
                            Spacer()
                            Text("State Status").font(.title).bold().opacity(0.6)
                            Spacer()
                        }
                        
                        // view containing boxes to display the data
                        StateInfoBox(left: "Confirmed Dayily:", right: "\(state.confirmed_daily ?? 0)").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.confirmed_color))
                        StateInfoBox(left: "Confirmed Total:", right: "\(state.confirmed ?? 0)").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.confirmed_color))
                        StateInfoBox(left: "Confirmed Rate:", right: "\(Int(confirm_rate.rounded()))%").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.confirmed_color))
                        StateInfoBox(left: "Death Dayily:", right: "\(state.deaths_daily ?? 0)").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.death_color))
                        StateInfoBox(left: "Death Total:", right: "\(state.deaths ?? 0)").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.death_color))
                        StateInfoBox(left: "Population:", right: "\(state.population ?? 0)").padding(6).background(RoundedRectangle(cornerRadius: 20).fill(manager.population_color))

                    }.padding(5)
                     .background(RoundedRectangle(cornerRadius: 20)
                     .fill(.white))
                     .shadow(radius: 6)
                     .padding(9)
                }
            }
            
            .navigationTitle(Text(state.state ?? "state"))
               
               
        }.toolbar(){
            // button for following a state
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    if let follow = state.follow{
                        if follow == true{
                            state.follow = false
                        }else{
                            state.follow = true
                        }
                    }else{
                        state.follow = true
                    }
                    manager.checkFollowed()
                }){
                    if state.follow == true{
                        Image(systemName: "star.fill")
                    }else{
                        Image(systemName: "star")
                    }
                }}
       
        }
        
        
       
        
        
        
    }
}


