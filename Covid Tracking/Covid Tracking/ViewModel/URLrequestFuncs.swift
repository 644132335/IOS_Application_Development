//
//  URLrequestFuncs.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/19.
//

import Foundation

extension CovidManager{
    
    // populate day info with given url
    func getDayInfo(Inurl: String) async {
        guard let url = URL(string: Inurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else{
            print("Invalid URL")
            return
        }
        do{
            let(data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                return
            }
                if let decodedResponse = try? JSONDecoder().decode([DayInfo].self, from: data) {
                        DispatchQueue.main.async {
                            // get info from the request and put them into dayinfos list
                            self.dayinfos = decodedResponse
                            self.covidData = []
                        }

                    return
                }
           
            print("Fetch failed")
        
        }catch{
            print("catch in do")
            //print(error)
        }
    }
    
    //request to get data from each country
    func getCountryInfo() async{
        guard let url = URL(string: countryUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else{
            print("Invalid URL")
            return
        }
        
        do{
            let(data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                return
            }
                if let decodedResponse = try? JSONDecoder().decode([countryInfo].self, from: data) {
                        DispatchQueue.main.async {
                            //request country info and put them into country list and sort them
                            self.countryTop5=[]
                            self.countryInfos = decodedResponse
                            self.countrySorted = decodedResponse
                            self.sortCountry()
                            for i in(0...9){
                                self.countryTop5.append(self.countrySorted.reversed()[i])
                                
                            }
                            self.getGraphData()
                        }

                    return
                }
            print("Fetch failed")
        }catch{
            print(error)
            print("Fetch failed")
        }
        
    }
    
    
    //request to get meta data
    func getMetaInfo() async{
        let metaUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/metadata"
        guard let url = URL(string: metaUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else{
            print("Invalid URL")
            return
        }
        do{
            let(data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                return
            }
                if let decodedResponse = try? JSONDecoder().decode(locationInfo.self, from: data) {
                        DispatchQueue.main.async {
                            // get the meta info for pickers
                            self.usStates = decodedResponse.states_us
                        }

                    return
                }
            print("Fetch failed")
        }catch{
            print(error)
            print("Fetch failed")
        }
        
       
    }
    

    
    
    // request with given date range and location
    func changeUrlDate(minDate: String, maxDate: String, state: String, county: String) async{
        let newUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/us_only?state="+state+"&county="+county+"&min_date="+minDate+"T00:00:00.000Z&max_date="+maxDate+"T00:00:00.000Z"
        await getDayInfo(Inurl: newUrl)
        
        DispatchQueue.main.async {
            // populate the datainfo list and fill up the graph data
            self.covidData=[]
            self.getGraphData()
        }
    }
    
    
    //populate the county based on the state
    func getCounty(state: String) async{
        
        let newUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/us_only?state="+state+"&min_date=2021-11-19T00:00:00.000Z&max_date=2021-11-19T00:00:00.000Z"
        guard let url = URL(string: newUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else{
            print("Invalid URL")
            return
        }
        do{
            let(data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                return
            }
                if let decodedResponse = try? JSONDecoder().decode([DayInfo].self, from: data) {
                        DispatchQueue.main.async {
                            // populate the counties data
                            self.usCounties = []
                            self.stateinfos = decodedResponse
                            for i in self.stateinfos{
                                self.usCounties.append(i.county)
                            }
                            if self.usCounties.contains(self.county){
                                
                            }else{
                                self.county = self.usCounties[0]
                            }
                            
                        }

                    return
                }
            print("Fetch failed")
        }catch{
            print(error)
            print("Fetch failed")
        }
           
    }
    
    
    // request to states and combine all counties within a state into one state data
    // get states total confirmed and etc. and put them into a list
    func getStatesInfo() async{
        let stateUrl = "https://webhooks.mongodb-stitch.com/api/client/v2.0/app/covid-19-qppza/service/REST-API/incoming_webhook/us_only?min_date="+dateAgo(day: 2)+"T00:00:00.000Z&max_date="+dateAgo(day: 2)+"T00:00:00.000Z"
        guard let url = URL(string: stateUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else{
            print("Invalid URL")
            return
        }
        do{
            let(data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
                return
            }
                if let decodedResponse = try? JSONDecoder().decode([StateInfo].self, from: data) {
                        DispatchQueue.main.async {
                            //get all states and counties info
                            self.allinfo = decodedResponse
                            
                            // set the state to old state used to compare it with next for loop i
                            var state = ""
                            
                            // for the data we got, we need to add all the data (confirmed cases) within a state since different counties have same states
                            for i in (0...self.allinfo.count-1){
                                // speed up the loop since we added all the ones that are in one state, we do not need to readd them for the second county, so jump if the state is the state we last added
                                if self.allinfo[i].state==state{
                                }else{
                                    // init data for a state
                                    state = self.allinfo[i].state ?? ""
                                    var stateConfirm = self.allinfo[i].confirmed_daily ?? 0
                                    var stateConfirmt = self.allinfo[i].confirmed ?? 0
                                    var stateDeath = self.allinfo[i].deaths_daily ?? 0
                                    var stateDeatht = self.allinfo[i].deaths ?? 0
                                    var population = self.allinfo[i].population ?? 0
                                    if i==self.allinfo.count-1{
                                        break
                                    }
                                    for j in(i+1...self.allinfo.count-1){
                                        // add each county into its state
                                        if self.allinfo[i].state==self.allinfo[j].state{
                                            stateConfirm += self.allinfo[j].confirmed_daily ?? 0
                                            stateConfirmt += self.allinfo[j].confirmed ?? 0
                                            stateDeath += self.allinfo[j].deaths_daily ?? 0
                                            stateDeatht += self.allinfo[j].deaths ?? 0
                                            population += self.allinfo[j].population ?? 0
                                        }
                                    }
                                    // when finish adding all county, add the state with its info into a statstat list
                                    self.stateStat.append(StateInfo(_id: self.allinfo[i]._id, country_iso3: self.allinfo[i].country_iso3, county: "", state: self.allinfo[i].state, population: population, date: self.allinfo[i].date, confirmed: stateConfirmt, confirmed_daily: stateConfirm, deaths_daily: stateDeath, deaths: stateDeatht))
                                }
                                }
                            //sort the state by its case
                            self.sortState()
                                
                        }

                    return
                }
            print("state Fetch failed")
        }catch{
            print(error)
            print("Fetch failed")
        }
    }
}
