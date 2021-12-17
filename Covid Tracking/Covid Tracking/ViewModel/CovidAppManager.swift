//
//  CovidAppManager.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/13.
//

import Foundation
import SwiftUI

class CovidManager:ObservableObject{
    
    //stateful datas
    @Published var dayinfos = [DayInfo]()
    @Published var stateinfos = [DayInfo]()
    @Published var stateStat = [StateInfo]()
    @Published var allinfo = [StateInfo]()
    @Published var stateSorted : [StateInfo] = [] {
        didSet{
            saveStates()
        }
    }
    @Published var countryInfos = [countryInfo]()
    @Published var countrySorted = [countryInfo]()
    @Published var countryTop5 = [countryInfo]()
    @Published var todayInfo : DayInfo = DayInfo.standard
    @Published var covidData :[(String, Int)] = []
    @Published var country = ""
    @AppStorage("state") var state = "Pennsylvania"
    @AppStorage("county") var county = "Centre"
    @Published var usStates : [String] = []
    @Published var usCounties : [String] = []
    @Published var apiUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/us_only?state=New York&county=New York&min_date=2021-11-08T00:00:00.000Z&max_date=2021-11-15T00:00:00.000Z"
    @Published var countryUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/countries_summary?min_date=2021-11-10T00:00:00.000Z&max_date=2021-11-10T00:00:00.000Z"
    @Published var duration : Duration = .week
    @Published var statesFollow : Bool = false
    @Published var CountryFollow : Bool = false
    
    //gradient colors
    var confirmed_color = LinearGradient(gradient: Gradient(colors: [.yellow.opacity(0.6),.orange.opacity(0.6)]),startPoint: .leading, endPoint: .trailing)
    var death_color = LinearGradient(gradient: Gradient(colors: [.red.opacity(0.6),.orange.opacity(0.6)]),startPoint: .leading, endPoint: .trailing)
    var population_color = LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.6),.green.opacity(0.6)]),startPoint: .leading, endPoint: .trailing)

    
    init() {
       
        //init all asyc function
        Task{
            await getMetaInfo()
            await getCountryInfo()
            await getCounty(state: state)
            await changeUrlDate(minDate: dateAgo(day: 7), maxDate: dateFormatToString(date: Date()),state: state, county: county)
            await getStatesInfo()
        }
       
        
    }
    
    
    //populate the covid data for the graph
    func getGraphData(){
        covidData=[]
        for i in dayinfos{
            if let index = i.date.firstIndex(of: "T") {
                let dateFormatted = i.date.prefix(upTo: index)
                if i.confirmed_daily<0{
                    covidData.append((String(dateFormatted),0))
                }else{
                    covidData.append((String(dateFormatted),i.confirmed_daily))
                }
            }
        }
        if dayinfos.isEmpty{
        }else{
            populateNumData()
        }
    }
    
    
    // refresh data
    func refreshData() async{
        // set graph data to be empty in order to have the graph redraw the correct graph
        covidData=[]
        
        if duration == .month{
            await changeUrlDate(minDate:dateAgo(day: 30), maxDate: dateFormatToString(date: Date()), state: state, county: county)
        }
        else if duration == .t_month{
            await changeUrlDate(minDate: dateAgo(day: 90), maxDate: dateFormatToString(date: Date()), state: state, county: county)
        }
        else if duration == .s_month{
            await changeUrlDate(minDate: dateAgo(day: 180), maxDate: dateFormatToString(date: Date()), state: state, county: county)
        }
        else if duration == .year{
            await changeUrlDate(minDate: dateAgo(day: 365), maxDate: dateFormatToString(date: Date()), state: state, county: county)
        }
        else{
            await changeUrlDate(minDate: dateAgo(day: 7), maxDate: dateFormatToString(date: Date()), state: state, county: county)
            
        }
    }
    
    // populate the box data
    func populateNumData(){
        let data = dayinfos[dayinfos.count-1]
        todayInfo.confirmed_daily=data.confirmed_daily
        todayInfo.confirmed=data.confirmed
        todayInfo.deaths=data.deaths
        todayInfo.deaths_daily=data.deaths_daily
        todayInfo.population=data.population
    }
    
    // sort country by cases
    func sortCountry(){
        let newlst = countrySorted.sorted{
            $0.confirmed<$1.confirmed
        }
        countrySorted = newlst
       
    }
    
    // sort states by cases
    func sortState(){
        let newlst = stateStat.sorted{
            $0.confirmed ?? 0 > $1.confirmed ?? 0
        }
        //stateSorted = newlst
        guard
            let data = UserDefaults.standard.data(forKey: "StateSort_lst"),
            let savedItems = try? JSONDecoder().decode([StateInfo].self, from: data)
        else{return self.stateSorted = newlst}
        self.stateSorted = savedItems
        checkFollowed()
        
    }
    
    //find sort state indices
    func findIndStat(statename: String) -> Int{
        for i in stateSorted.indices{
            if stateSorted[i].state == statename{
               return i
            }
        }
        return 0
    }
    
    //check if some states are followed or not
    func checkFollowed(){
        for i in stateSorted{
            if i.follow == true{
                statesFollow = true
                return
            }
        }
        statesFollow = false
    }
    
    //save followed states
    func saveStates(){
        if let encodedData = try? JSONEncoder().encode(stateSorted){
            UserDefaults.standard.set(encodedData, forKey: "StateSort_lst")
        }
    }
    
}
