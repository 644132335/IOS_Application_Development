//
//  StateInfoBox.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/12/9.
//

import SwiftUI

struct StateInfoBox: View {
    var left : String
    var right : String
    var body: some View {
        HStack{
            //data layout inside state box
            Spacer().frame(width: 10)
            Text(left).bold().foregroundColor(.black.opacity(0.6))
            Spacer()
            Text(right).bold().foregroundColor(.black.opacity(0.6))
            Spacer().frame(width: 10)
        }
    }
}

