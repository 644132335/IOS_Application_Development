//
//  DateManager.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/19.
//

import Foundation

extension CovidManager{
    // get today's date by yyyy-mm-dd format
    func dateFormatToString(date: Date) -> String{
        let formator = DateFormatter()
        formator.dateFormat = "yyyy-MM-dd"
        return formator.string(from: date)
    }
    
    //get date from certain days ago
    func dateAgo(day: Int) -> String{
        let date = Calendar.current.date(byAdding: .day, value: -day, to: Date())!
        return dateFormatToString(date: date)
    }
    
    //format string date
    func formatStringDate(date: String) -> String{
        if let index = date.firstIndex(of: "T") {
            let dateFormatted = date.prefix(upTo: index)
            return String(dateFormatted)
        }else{
            return date
        }
        
}
}
