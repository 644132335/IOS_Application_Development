//
//  allCountriesV.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/12/5.
//

import SwiftUI

struct allCountriesV: View {
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        List{
            // view to show all countries data
            ForEach(manager.countryInfos, id: \._id){i in
                DisclosureGroup(i.country){
                    Text("Confirmed: \(i.confirmed)")
                    Text("Deaths: \(i.deaths)")
                }

            }
        }
    }
}

struct allCountriesV_Previews: PreviewProvider {
    static var previews: some View {
        allCountriesV()
    }
}
