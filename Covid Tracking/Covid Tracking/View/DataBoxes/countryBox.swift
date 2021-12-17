//
//  countryBox.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/25.
//

import SwiftUI

struct countryBox: View {
    var rank : Int
    var country : String
    var confirmed : Int
    var death : Int
    
    var body: some View {
        VStack{
            // country box with provided data
            HStack{
                Spacer()
                Text("\(rank)").font(.title).bold().foregroundColor(.black.opacity(0.6))
                Spacer()
            }.padding(5)
            HStack{
                Spacer()
                Text(country).font(.title).foregroundColor(.black.opacity(0.6))
                Spacer()
            }
            Spacer().frame(width: 10)
            HStack(alignment: .center){
                Spacer()
                VStack(alignment: .center){
                    Text("Confirmed").bold().foregroundColor(.black.opacity(0.6))
                    Text("\(confirmed)").font(.headline).foregroundColor(.orange.opacity(0.7))
                   
                }
                Spacer()
                VStack{
                    Text("Death").bold().foregroundColor(.black.opacity(0.6))
                    Text("\(death)").font(.headline).foregroundColor(.red.opacity(0.7))
                }
                Spacer()
            }.padding()
        }
        .padding(5)
        .background( RoundedRectangle(cornerRadius: 20)
            .fill(.white))
            .shadow(radius: 4)
            .padding()
    }
}


