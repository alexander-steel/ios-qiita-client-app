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
            print("saveFavoriteQiitaItem")
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

            let qiitaItem: QiitaItem = QiitaItem(title: qiitaObj.title, id: qiitaObj.id, url: qiitaObj.url , user: User(thumbnailUrl: qiitaObj.user!.thumbnailUrl))
            qiitaitemList.append(qiitaItem)
        }

        return qiitaitemList
    }

    func deleteQiitaItems() {
        let realm = try! Realm()
        let result = realm.objects(FavoriteQiitaItem.self)
        do {
          try realm.write {
              realm.delete(result)
          }
        } catch {
          print("Error \(error)")
        }
    }
}
