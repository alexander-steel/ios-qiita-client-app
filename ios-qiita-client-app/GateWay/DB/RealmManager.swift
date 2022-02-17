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

    func getFavoriteQiitaItem() -> [QiitaItem]{
        let realm = try! Realm()
        let result = realm.objects(FavoriteQiitaItem.self)
        print("getfav")
        let qiitaitemList = result.reduce(into: [QiitaItem]()) { (list, element) -> () in

            list.append(QiitaItem(title: element.title, id: element.id, url: element.url, user: User(thumbnailUrl: element.user!.thumbnailUrl)))
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
