//
//  MainView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = SerieViewModel()
    
    var body: some View {
        let gridItems = [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.PRIMARY_GREEN)
                        .padding(.leading, 10)
                    
                    TextField(SEARCH_STR, text: $viewModel.searchText)
                        .font(.mRegular(size: 14))
                        .padding(5)
                        .disableAutocorrection(true)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .onSubmit {
                            viewModel.searchSeries()
                        }
                    
                    Button(action: {
                        viewModel.searchText = ""
                        viewModel.currentPage = 0
                        viewModel.loadMoreSeries()
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.PRIMARY_GREEN)
                            .padding(.trailing, 10)
                    }
                }
                .frame(height: 50)
                .background(Color.PRIMARY_BLUE)
                
                Spacer()
                
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
                                .onAppear {
                                    if (!viewModel.searching) {
                                        if let index = viewModel.series.firstIndex(where: { $0.id == serie.id }),
                                           index == viewModel.series.count - 1 {
                                            viewModel.loadMoreSeries()
                                        }
                                    }
                                }
                                .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .onAppear {
                DispatchQueue.main.async {
                    if !viewModel.searching {
                        viewModel.loadMoreSeries()
                    }
                }
            }
            .overlay() {
                if (viewModel.isLoading) {
                    LoadingViewC()
                        .presentationDetents([.large])
                        .interactiveDismissDisabled(true)
                }
            }
        }
        .toolbarBackground(.PRIMARY_BLUE, for: .tabBar)
    }
}

#Preview {
    MainView()
}
