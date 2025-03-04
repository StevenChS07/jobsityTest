//
//  LoadingViewC.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI

struct LoadingViewC: View {
    var body: some View {
        ZStack {
            VStack {
                ProgressView(LOADING_STR)
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .padding()
                    .font(.mBold(size: 18))
                    .foregroundColor(.black)
            }
            .frame(width: 200, height: 150)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
    }
}

#Preview {
    LoadingViewC()
}
