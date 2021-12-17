//
//  countryView.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/15.
//

import SwiftUI

struct countryView: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
                // country confirmed ranking area
                VStack{
                    ForEach(manager.countryTop5.indices ,id: \.self){i in
                        NavigationLink(destination: ContryDetailView(state: manager.countryTop5[i])){
                            countryBox(rank: i+1, country: manager.countryTop5[i].country, confirmed: manager.countryTop5[i].confirmed, death: manager.countryTop5[i].deaths)
                        }.foregroundColor(.black)
                        
                    }
                }
            }
            //link to see all country status
            .toolbar(){
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink("See All"){
                        allCountriesV()
                    }
                }}
            }.navigationTitle("TOP 10 COUNTRIES")
                .navigationBarTitleDisplayMode(.inline)
                
        }
        
    }
}


