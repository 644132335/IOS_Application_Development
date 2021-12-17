//
//  CountryInfo.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/16.
//

import Foundation

struct countryInfo : Codable{
    var _id : String
    var confirmed : Int
    var deaths : Int
    var country : String
    var recovered : Int
    var confirmed_daily : Int
    var deaths_daily: Int
    var population: Int?
}
