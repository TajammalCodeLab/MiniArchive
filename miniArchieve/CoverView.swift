//
//  CoverView.swift
//  miniArchieve
//
//  Created by Umair on 02/04/2026.
//


import SwiftUI

struct CoverView: View {
    let color: Color
    let title: String?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
            
            if let title = title{
                VStack (alignment: .leading, spacing: 5){
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .multilineTextAlignment(.leading)
                    Divider().background(.white)
                    Divider().background(.white)
                }
                .padding(20)
            }
        }
        .shadow(radius: 5)
    }
}
