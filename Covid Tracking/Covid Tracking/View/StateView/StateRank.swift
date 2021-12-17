//
//  Setting.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/15.
//

import SwiftUI

struct StateView: View {
    @EnvironmentObject var manager : CovidManager
    @State var search = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    //search bar area
                    SearchBar(searchText: $search).padding()
                    
                    //followed states area, nothing if there is no states being followed
                    HStack{
                        if manager.statesFollow == false{
                        
                        }
                        else{
                            if search.isEmpty{
                                Spacer().frame(width: 15)
                                Text("States Followed").bold().font(.title2).opacity(0.6).padding(3)
                                Spacer()
                            }
                            
                        }
                        
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach($manager.stateSorted){$j in
                                if search.isEmpty{
                                    if j.follow == true{
                                        NavigationLink(destination: StateDetailView(state: $j)){
                                            countryBox(rank: manager.findIndStat(statename: j.state ?? "Unknown")+1, country: j.state ?? "Unknown", confirmed: j.confirmed ?? 0, death: j.deaths ?? 0)
                                        }.foregroundColor(.black)
                                    }
                                }
                            }

                        }
                    }
                   
                    
                    Spacer().frame(height: 20)
                    
                    // unfollowed states with confirmed rank
                    Group{
                        VStack{
                            if search.isEmpty{
                                Text("States Cases Ranking").bold().font(.title2).opacity(0.6).padding(3)
                            }
                            
                            // if editing search bar it will only show results else display all ranking
                            ForEach($manager.stateSorted) {$i in
                                if ((i.state!.contains(search))){
                                    NavigationLink(destination: StateDetailView(state: $i)){
                                        countryBox(rank: manager.findIndStat(statename: i.state ?? "Unknown")+1, country: i.state ?? "Unknown", confirmed: i.confirmed ?? 0, death: i.deaths ?? 0)
                                    }.foregroundColor(.black)
                                    
                                }else if search.isEmpty{
                                    NavigationLink(destination: StateDetailView(state: $i)){
                                        countryBox(rank: manager.findIndStat(statename: i.state ?? "Unknown")+1, country: i.state ?? "Unknown", confirmed: i.confirmed ?? 0, death: i.deaths ?? 0)
                                    }.foregroundColor(.black)
                                }
                            }
                        }
                        
                    }.padding(5)
                        
                        .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                    .shadow(radius: search.isEmpty ? 4 : 0)
                   
                    
                    
                }.navigationTitle("STATES STAT")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        
            
            }
}

