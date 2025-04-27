//
//  DetailImageView.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct DetailImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: DetailViewModel
    let imageId: String

    init(imageId: String) {
        let service = PicSumImageService()
        _viewModel = StateObject(wrappedValue: DetailViewModel(service: service))
        self.imageId = imageId
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header View
            DetailHeaderView(title: "detailImage") {
                // Back button action
                presentationMode.wrappedValue.dismiss()
            }
            .frame(height: 60)

            Spacer()
            // Image View
            if let imageUrl = URL(string: viewModel.detailModel?.downloadUrl ?? "") {
                KFImage(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .scaledToFill()
                    .frame(height: 200)
            }
            Spacer()
            // Content Label
            Text(viewModel.getContentData())
                .font(.custom("Subtitle3", size: 16)) // Assuming custom font setup
                .foregroundColor(Color.black)   // Assuming custom color setup
                .padding(.horizontal, 15)

            Spacer()
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            Task {
                await viewModel.loadDetail(imageId: imageId)
            }
        }
    }
}

// MARK: - Preview (Optional for testing in Xcode's Canvas)
struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(imageId: "sampleImageId")
    }
}
