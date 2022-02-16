//
//  QiitaUsecase.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import Foundation

protocol QiitaUsecaseProtocol {
    func getQiitaItems(word: String) async throws -> [QiitaItem]
    func saveFavoriteQiitaItem(qiitaItem: QiitaItem)
    func getFavoriteQiitaItems() -> [QiitaItem]
    func deleteQiitaItems()
}

class QiitaUsecase: QiitaUsecaseProtocol {

    private let repository: QiitaRepositoryProtocol

    init(repository: QiitaRepositoryProtocol) {
        self.repository = repository
    }

    func getQiitaItems(word: String) async throws -> [QiitaItem] {
        return try await repository.getQiitaItems(word: word)
    }

    func saveFavoriteQiitaItem(qiitaItem: QiitaItem) {
        return repository.saveFavoriteQiitaItem(qiitaItem: qiitaItem)
    }

    func getFavoriteQiitaItems() -> [QiitaItem] {
        return repository.getFavoriteQiitaItems()
    }

    func deleteQiitaItems() {
        repository.deleteQiitaItems()
    }
}
