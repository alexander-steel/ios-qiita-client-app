//
//  Article.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//

import Foundation
import UIKit

struct QiitaItem: Decodable, Equatable {

    let title: String
    let id: String
    let url: String
    let user: User
    
    
    //
    //XcTestのために準拠させる必要があるだけなので、実装に使われることはない
    //プロダクトに使用するならこの辺考える必要ありhttps://qiita.com/uhooi/items/638a6116278a3e591773
    //
    static func == (_rItem: QiitaItem, _lItem: QiitaItem) -> Bool {
        return _rItem.title == _lItem.title
        && _rItem.id == _lItem.id
        && _rItem.url == _lItem.url
        && _rItem.user.thumbnailUrl == _lItem.user.thumbnailUrl
    }
}

struct User: Decodable {
    let thumbnailUrl: String
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "profile_image_url"
    }
}
