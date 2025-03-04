//
//  ImageLoaderC.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import SwiftUI

struct ImageLoaderC: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(10)
                
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .foregroundColor(.white)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}
