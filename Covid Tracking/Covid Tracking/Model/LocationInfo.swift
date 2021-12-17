//
//  LocationInfo.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/22.
//

import Foundation

//for meta data
struct locationInfo: Codable{
    var countries : [String]
    var states : [String]
    var states_us : [String]
}
