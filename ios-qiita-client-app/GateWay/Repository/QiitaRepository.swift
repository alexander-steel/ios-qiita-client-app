//
//  QiitaRepository.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//

import Foundation

protocol QiitaRepositoryProtocol {
    func getQiitaItems(word: String) async throws -> [QiitaItem]
    func saveFavoriteQiitaItem(qiitaItem: QiitaItem)
    func getFavoriteQiitaItems() -> [QiitaItem]
    func deleteQiitaItems()
}

class QiitaRepository: QiitaRepositoryProtocol {
    private let apiservice: QiitaApiServiceProtocol
    private let realmManager = RealmManager()

    init(apiservice: QiitaApiServiceProtocol) {
        self.apiservice = apiservice
    }

    func getQiitaItems(word: String) async throws -> [QiitaItem] {
        return try await apiservice.getQiitaItems(word: word)
    }

    func getFavoriteQiitaItems() -> [QiitaItem] {
        return self.realmManager.getFavoriteQiitaItem()
    }

    func saveFavoriteQiitaItem(qiitaItem: QiitaItem) {
        self.realmManager.saveFavoriteQiitaItem(qiitaItem: qiitaItem)
    }

    func deleteQiitaItems() {
        self.realmManager.deleteQiitaItems()
    }
}
