//
//  RealmManager.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/16.
//

import Foundation
import RealmSwift

protocol LocalManager {
    func saveFavoriteQiitaItem(qiitaItem: QiitaItem)
    func getFavoriteQiitaItem() -> [QiitaItem]
}

final class RealmManager: LocalManager {
    func saveFavoriteQiitaItem(qiitaItem: QiitaItem) {
        let realm = try! Realm()

        let favoriteQiitaItem = FavoriteQiitaItem(qiitaItem: qiitaItem)

        do {
            try realm.write {
                realm.add(favoriteQiitaItem)
            }
        } catch {
            print(error)
        }
    }

    func getFavoriteQiitaItem() -> [QiitaItem] {
        let realm = try! Realm()
        let result = realm.objects(FavoriteQiitaItem.self)

        var qiitaitemList: [QiitaItem] = []

        for qiitaObj in result {
            let qiitaItem: QiitaItem = qiitaObj.toDTO()
            qiitaitemList.append(qiitaItem)
        }

        return qiitaitemList
    }
}
