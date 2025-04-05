//
//  EmptyImageCell.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation
import SwiftUI

struct EmptyImageCell: View {
    var body: some View {
        HStack {
            Spacer()
            Text("No images available")
                .frame(height: 122)
            Spacer()
        }
    }
}
