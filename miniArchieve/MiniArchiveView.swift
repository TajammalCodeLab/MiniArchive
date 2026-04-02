//
//  MiniArchiveView.swift
//  miniArchive
//
//  Created by Umair on 02/04/2026.
//

import SwiftUI

struct MiniArchiveView: View {
    
    // Sample data for the stamps
    let colors: [Color] = [.orange, .pink, .black, .gray]
    let colorsStemp: [Color] = [.teal, .mint, .indigo, .cyan, .indigo, .cyan]
    let stamps = ["Stamp 1", "Stamp 2", "Stamp 3", "Stamp 4", "Stamp 3", "Stamp 4"]
    let stampsImages = ["bird", "cloud", "sun.max.fill", "moon", "sun.max.fill", "moon"]
    
    @Namespace private var stampNamespace
    @State private var isOpen = false
    @State private var selectedColor: Color = .orange
    @State private var selectedStampIndex: Int? = nil
    var body: some View {
        ZStack {
            content
            if let index = selectedStampIndex {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) { selectedStampIndex = nil }
                    }
                StampView(title: stamps[index], color: colorsStemp[index], image: stampsImages[index])
                    .matchedGeometryEffect(id: "stamp\(index)", in: stampNamespace)
                    .frame(width: 320, height: 450)
                    .transition(.scale(scale: 0.9).combined(with: .opacity))
                    .zIndex(2)
                    .onTapGesture {
                        withAnimation(.spring()) { selectedStampIndex = nil }
                    }
            }
        }
    }
    var content: some View {
        VStack(spacing: 50) {
            ZStack(alignment: .leading) {
                bottomCover
                cards
                topCover
            }
            coverColors
            
        }
    }
    var coverColors: some View {
        HStack(spacing: 20) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .onTapGesture {
                        withAnimation { selectedColor = color }
                    }
            }
        }
    }
    var topCover: some View {
        CoverView(color: selectedColor.opacity(0.95), title: "集めたもの\nMini Archive")
            .frame(width: 220, height: 300)
            .rotation3DEffect(
                .degrees(isOpen ? -60 : -10),
                axis: (x: 0, y: 1, z: 0),
                anchor: .leading, // Anchor to the left to "hinge" like a book
                perspective: 0.3
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isOpen.toggle()
                }
            }
    }
    var bottomCover: some View {
        CoverView(color: selectedColor, title: nil)
            .frame(width: 250, height: 300)
    }
    var cards: some View {
        ZStack{
            if isOpen {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -40) { // Negative spacing mimics the overlap in the video
                        ForEach(stamps.indices, id: \.self) { index in
                            StampView(title: stamps[index], color: colorsStemp[index], image: stampsImages[index])
                                .matchedGeometryEffect(id: "stamp\(index)", in: stampNamespace)
                                .offset(y: index.isMultiple(of: 2) ? 5 : -5) // Subtle staggered height
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                                        selectedStampIndex = index
                                    }
                                }
                        }
                    }
                    .padding(.leading, 40)
                    .padding()
                }
                .transition(.asymmetric(insertion: .identity, removal: .opacity))
            } else {
                ZStack {
                    ForEach(stamps.indices.suffix(3), id: \.self) { index in
                        StampView(title: stamps[index], color: colorsStemp[index], image: stampsImages[index])
                            .matchedGeometryEffect(id: "stamp\(index)", in: stampNamespace)
                        // Fans out the stamps behind the cover
                            .rotationEffect(.degrees(Double(index) * 8)) // Fan them out
                            .offset(x: CGFloat(index * 5), y: CGFloat(index * -8))
                            .zIndex(Double(stamps.count - index)) // Explicitly ensure
                        
                    }
                }
                .padding(.leading, 40)
            }
        }
    }
}

#Preview {
    MiniArchiveView()
}
