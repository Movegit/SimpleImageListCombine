//
//  MainHeaderView.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI

struct MainHeaderView: View {
    let title: String

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("MainHeaderTitle")
                .accessibilityElement(children: .ignore)
            Spacer()
        }
        .accessibilityIdentifier("MainHeaderView")
        .accessibilityElement(children: .contain)
    }
}
