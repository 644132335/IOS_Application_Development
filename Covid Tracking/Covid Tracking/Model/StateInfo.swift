//
//  StateInfo.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/12/6.
//

import Foundation

struct StateInfo : Codable, Identifiable{
    var _id : String
    var country_iso3 : String?
    var county : String?
    var state : String?
    var population : Int?
    var date : String?
    var confirmed : Int?
    var confirmed_daily : Int?
    var deaths_daily : Int?
    var deaths : Int?
    var follow : Bool?
    var id : String {_id}
}
