//
//  StampView.swift
//  miniArchieve
//
//  Created by Umair on 02/04/2026.
//


import SwiftUI

struct StampView: View {
    let title: String
    let color: Color
    let image: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .overlay(
                    // Inner image/design placeholder
                    VStack {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                        Text(title).font(.caption2)
                    }
                )
        }
        .frame(width: 180, height: 240)
    }
}
