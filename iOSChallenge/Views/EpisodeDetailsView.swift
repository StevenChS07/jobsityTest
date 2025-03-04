//
//  EpisodeDetailsView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import SwiftUI

struct EpisodeDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var episode: Episode?
    @State private var summaryText: String = ""
    
    var body: some View {
        ScrollView {
            
            ImageLoaderC(url: episode?.image?.original ?? "error", width: UIScreen.main.bounds.width - 32, height: 200)
                .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                .padding(.top, 20)
                .padding(.horizontal, 8)
            
            Text("Season \(episode?.season ?? 0)")
                .font(.mSemiBold(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.bottom, 1)
                .padding(.horizontal)
            
            Text(episode?.name ?? TITLE_STR)
                .font(.mBold(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
                .padding(.horizontal)
            
            Text(summaryText.isEmpty ? NO_SUMARY_AVAILABLE_STR : summaryText)
                .font(.mRegular(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
        }
        .onAppear {
            if let htmlSummary = episode?.summary {
                summaryText = htmlSummary.htmlToString()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.PRIMARY_GREEN)
                
                Text(BACK_STR)
                    .font(.mSemiBold(size: 14))
                    .tint(Color.white)
            }
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Episode \(episode?.number ?? 0)")
                    .font(.mBold(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.PRIMARY_BLUE, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    EpisodeDetailsView()
}
