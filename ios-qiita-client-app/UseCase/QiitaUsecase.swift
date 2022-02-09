//
//  QiitaUsecase.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import Foundation

protocol QiitaUsecaseProtocol {
    func getQiitaItems() async throws -> [QiitaItem]
}

class QiitaUsecase: QiitaUsecaseProtocol {
    private let repository: QiitaRepositoryProtocol

    init(repository: QiitaRepositoryProtocol) {
        self.repository = repository
    }

    func getQiitaItems() async throws -> [QiitaItem] {
        return try await repository.getQiitaItems()
    }
}
