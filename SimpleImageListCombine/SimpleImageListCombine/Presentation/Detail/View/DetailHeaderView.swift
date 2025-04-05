//
//  DetailHeaderView.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI

struct DetailHeaderView: View {
    let title: String
    let onBackButtonTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: onBackButtonTapped) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding()
            }
            .accessibilityIdentifier("detailHeaderBackButton")
            .accessibilityElement(children: .ignore)

            Spacer()

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .accessibilityIdentifier("detailHeaderTitleText")
                .accessibilityElement(children: .ignore)

            Spacer()

            Spacer() // Placeholder for alignment
        }
        .background(Color(UIColor.white))
        .accessibilityIdentifier("detailHeaderView")
        .accessibilityElement(children: .contain)
    }
}
