//
//  PicSumListDto.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//

import Foundation

struct PicSumListDto: Decodable {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
}
