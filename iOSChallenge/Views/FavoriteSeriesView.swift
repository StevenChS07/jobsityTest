//
//  FavoritedSeriesView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import SwiftUI

struct FavoriteSeriesView: View {
    @StateObject private var viewModel = FavortiteSerieViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let gridItems = [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 8) {
                    ForEach(viewModel.series) { serie in
                        NavigationLink(destination: SerieDetailsView(serie: serie)
                            .toolbar(.hidden, for: .tabBar)) {
                            VStack {
                                ImageLoaderC(url: serie.image?.original ?? "", width: 120, height: 180)
                                    .padding(.horizontal, 8)
                                
                                Text(serie.name ?? "")
                                    .font(.mSemiBold(size: 16))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 8)
                            }
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 300)
                            .background(.PRIMARY_BLUE)
                            .cornerRadius(10)
                            .padding(4)
                            .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear() {
            viewModel.fetchFavoriteSeries(ids: Array(userViewModel.user!.favoriteSeries))
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.PRIMARY_BLUE, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    FavoriteSeriesView()
}
