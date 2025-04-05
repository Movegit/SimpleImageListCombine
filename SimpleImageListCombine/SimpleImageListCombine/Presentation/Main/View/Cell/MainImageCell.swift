//
//  MainImageCell.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import Kingfisher
import SwiftUI

struct MainImageCell: View {
    let item: PicSumItem

    var body: some View {
        HStack {
            if let imageUrl = URL(string: item.downloadUrl) {
                KFImage(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                    }
            }

            VStack(alignment: .leading) {
                Text(item.author)
                    .font(Font(UIFont.customFont(.Body1)))
                    .foregroundColor(Color(UIColor.customColor(.pink100)))
                Text("ID: \(item.id)")
                    .font(Font(UIFont.customFont(.Body1)))
                    .foregroundColor(Color(UIColor.customColor(.pink100)))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
        .padding(.vertical, 10)
    }
}
