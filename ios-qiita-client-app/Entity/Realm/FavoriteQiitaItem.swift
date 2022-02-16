//
//  QiitaItem.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/15.
//

import Foundation
import RealmSwift

final class FavoriteQiitaItem: Object {
    @objc dynamic var title: String
    = ""
    @objc dynamic var id: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var user: FavoriteQiitaItemUser?

    convenience init(qiitaItem: QiitaItem) {
        self.init()
        self.title = qiitaItem.title
        self.id = qiitaItem.id
        self.url = qiitaItem.url
        self.user = FavoriteQiitaItemUser(user: qiitaItem.user)
    }
}

final class FavoriteQiitaItemUser: Object {
    @objc dynamic var thumbnailUrl: String = ""
    convenience init(user: User) {
        self.init()
        self.thumbnailUrl = user.thumbnailUrl
    }
}

extension FavoriteQiitaItem {
    func toDTO() -> QiitaItem {
        return QiitaItem.init(title: title, id: id, url: url, user: User(thumbnailUrl: FavoriteQiitaItemUser().toDTO().thumbnailUrl))
    }
}

extension FavoriteQiitaItemUser {
    func toDTO() -> User {
        return User.init(thumbnailUrl: thumbnailUrl)
    }
}
