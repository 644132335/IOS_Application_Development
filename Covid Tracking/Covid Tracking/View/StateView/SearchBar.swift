//
//  SearchBar.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/12/6.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    @FocusState private var focusedField: Bool
 
    var body: some View {
            //search bar
            HStack {
                    HStack {
                        TextField(" Search", text: $searchText, onEditingChanged: { _ in
                            self.showCancelButton = true
                        }).focused($focusedField)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText.isEmpty ? 0 : 1)
                        }
                    }
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    
                    if !searchText.isEmpty  {
                        Button("Cancel") {
                            
                            self.searchText = ""
                            self.showCancelButton = false
                            self.focusedField = false
                        }
                       
                        .foregroundColor(Color(.systemBlue))
                    }
                }
            }
        
    }



