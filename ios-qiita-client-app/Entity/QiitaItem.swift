//
//  Article.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//

import Foundation
import UIKit

struct QiitaItem: Decodable, Equatable {
    static func == (_: QiitaItem, _: QiitaItem) -> Bool {
        return true
    }

    let title: String
    let id: String
    let user: User
}

struct User: Decodable {
    let thumbnailUrl: String
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "profile_image_url"
    }
}
