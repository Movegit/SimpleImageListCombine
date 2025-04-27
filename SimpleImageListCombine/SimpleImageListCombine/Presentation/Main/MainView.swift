//
//  MainView.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel

    init() {
        let service = PicSumImageService()
        _viewModel = StateObject(wrappedValue: MainViewModel(service: service))
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header View
                MainHeaderView(title: "Pic List")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.white))

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.picList, id: \.id) { item in
                            NavigationLink(destination: DetailImageView(imageId: item.id)) {
                                MainImageCell(item: item)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .padding(0)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .navigationViewStyle(StackNavigationViewStyle())
                            .listRowSeparator(.hidden)
                            .onAppear {
                                if shouldLoadMoreData(for: item) {
                                    viewModel.triggerLoadMore()
                                }
                            }
                        }

                        if viewModel.picList.isEmpty {
                            EmptyImageCell()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .refreshable {
                    await viewModel.loadData(initialize: true)
                }
                .background(Color(UIColor.white))
            }
            .onAppear {
                Task {
                    await viewModel.loadData(initialize: viewModel.picList.isEmpty)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

    private func shouldLoadMoreData(for item: PicSumItem) -> Bool {
        guard let index = viewModel.picList.firstIndex(where: { $0.id == item.id }) else {
            return false
        }

        let thresholdIndex = viewModel.picList.count - 5
        return index >= thresholdIndex && !viewModel.isLoadingData && viewModel.hasNext
    }
}

#Preview {
    MainView()
}
