//
//  SerieDetailsView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import SwiftUI

struct SerieDetailsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SeasonViewModel()
    @State var serie: Serie?
    @State private var summaryText: String = ""
    @State var isFavorite: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: serie?.image?.original ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: UIScreen.main.bounds.width, height: 400)
                            .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.top, 10)
                        .padding(.horizontal)
                    
                    Text(serie?.name ?? TITLE_STR)
                        .font(.mBold(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    
                    Text(summaryText.isEmpty ? NO_SUMARY_AVAILABLE_STR : summaryText)
                        .font(.mRegular(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.horizontal)
                    
                    Text(GENRES_STR)
                        .font(.mBold(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(viewModel.genres)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.mRegular(size: 12))
                        .padding(.horizontal)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.horizontal)
                    
                    Text(SCHEDULE_STR)
                        .font(.mBold(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(viewModel.time)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.mRegular(size: 12))
                        .padding(.horizontal)
                    
                    Text(viewModel.days)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.mRegular(size: 12))
                        .padding(.horizontal)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.seasons) { season in
                        Text("Season \(season.number ?? 0)")
                            .font(.mBold(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if let episodes = viewModel.episodes[season.number ?? 0] {
                                    ForEach(episodes) { episode in
                                        NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                                            VStack {
                                                AsyncImage(url: URL(string: episode.image?.original ?? "")) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(10)
                                                        .frame(width: 225, height: 125)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                
                                                Text(episode.name ?? "")
                                                    .font(.mSemiBold(size: 16))
                                                    .foregroundStyle(.white)
                                                    .padding(.horizontal, 8)
                                                    .padding(.bottom, 8)
                                            }
                                            .frame(width: 250, height: 175)
                                            .background(.PRIMARY_BLUE)
                                            .cornerRadius(10)
                                            .padding(4)
                                            .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                        
                        Divider()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .background(Color.PRIMARY_BLUE)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getScheduleAndGeneres(serie: serie!)
            viewModel.fetchSeasons(id: serie?.id ?? 0)
            if let htmlSummary = serie?.summary {
                summaryText = htmlSummary.htmlToString()
            }
        }
        .padding()
        .overlay() {
            if (viewModel.isLoading) {
                LoadingViewC()
                    .presentationDetents([.large])
                    .interactiveDismissDisabled(true)
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
        .navigationBarItems(trailing: Button(action: {
            userViewModel.toggleFavoriteSerie(id: serie?.id ?? 0)
            isFavorite = !isFavorite
        }) {
            HStack {
                if (userViewModel.user!.favoriteSeries.contains(serie?.id ?? 0) ||
                    isFavorite) {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.PRIMARY_GREEN)
                }else {
                    Image(systemName: "bookmark")
                        .foregroundColor(.PRIMARY_GREEN)
                }
            }
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(serie?.name ?? TITLE_STR)
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
    SerieDetailsView()
}
