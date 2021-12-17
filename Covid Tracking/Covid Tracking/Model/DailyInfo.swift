//
//  DailyInfo.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/13.
//

import Foundation


struct DayInfo : Codable{
    var _id : String
    var country_iso3 : String
    var county : String
    var state : String
    var population : Int?
    var date : String
    var confirmed : Int
    var confirmed_daily : Int
    var deaths_daily : Int
    var deaths : Int
    
    static let standard = DayInfo(_id: "5fd1a17ca1fae2c111330893", country_iso3: "USA", county: "New York", state: "New York", population: 0, date: "2020-04-25T00:00:00.000Z", confirmed: 0, confirmed_daily: 0, deaths_daily: 0, deaths: 0)
}


