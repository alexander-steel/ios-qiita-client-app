//
//  QiitaRepository.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//

import Foundation

protocol QiitaRepositoryProtocol {
    func getQiitaItems(word: String) async throws -> [QiitaItem]
}

class QiitaRepository: QiitaRepositoryProtocol {
    private let apiservice: QiitaApiServiceProtocol

    init(apiservice: QiitaApiServiceProtocol) {
        self.apiservice = apiservice
    }

    func getQiitaItems(word: String) async throws -> [QiitaItem] {
        return try await apiservice.getQiitaItems(word: word)
    }
}
