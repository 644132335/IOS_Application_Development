//
//  dataBox.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/18.
//

import SwiftUI
import SwiftUICharts

struct dataBox: View {
    var text: String
    var data: Int
    var dataColor : Color
    @EnvironmentObject var manager : CovidManager
    var body: some View {
        // data layout inside the box
        VStack{
            HStack{
                Text(text).bold().opacity(0.6)
                Spacer()
            }
            Spacer().frame(height: 20)
            HStack{
                Text("\(data)").bold().font(.title).foregroundColor(dataColor)
                Spacer()
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 20)
            .fill(.white))
            .shadow(radius: 6)
            
    }
}


