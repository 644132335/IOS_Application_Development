//
//  DataDuration.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/19.
//

import Foundation

enum Duration: String, Codable, Identifiable, CaseIterable{
    var id: String{self.rawValue}
    
    case week = "Past Week"
    case month = "Past Month"
    case t_month = "Past 3 Month"
    case s_month = "Past 6 Month"
    case year = "Past Year"
    
}
