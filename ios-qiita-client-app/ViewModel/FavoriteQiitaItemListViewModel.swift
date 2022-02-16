//
//  FavoriteQiitaItemListViewModel.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/15.
//

import Foundation
import UIKit

final class FavoriteQiitaItemListViewModel {
    let loadFavoriteItem = Notification.Name("loadFavoriteQiitaItems")
    private let usecase: QiitaUsecaseProtocol

    init(usecase: QiitaUsecaseProtocol){
        self.usecase = usecase
    }

    @objc func loadFavoriteQiitaItems(){
        var result: [QiitaItem] = []
        result = usecase.getFavoriteQiitaItems()
        NotificationCenter.default.post(name: Notification.Name(rawValue: loadFavoriteItem.rawValue), object: result)
    }
}
