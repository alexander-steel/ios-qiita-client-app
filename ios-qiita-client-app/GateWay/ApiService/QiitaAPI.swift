//
//  QiitaAPI.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//

import Alamofire
import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void

protocol QiitaApiServiceProtocol {
    func getQiitaItems() async throws -> [QiitaItem]
}

class QiitaApiService: QiitaApiServiceProtocol {
    let baseUrl = "https://qiita.com/api/v2"
    func getQiitaItems() async throws -> [QiitaItem] {
        let result = try await AF.request("\(baseUrl)/items").publish([QiitaItem].self)
        return result
    }
}

//
// Alamofireにはまだasync awaitで扱える口がないので、変換するおまじない
//
extension DataRequest {
    func publish<T>(_ type: T.Type) async throws -> T where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            self.response { response in
                switch response.result {
                case let .success(element): do {
                        let decodedResponse = try JSONDecoder().decode(type, from: element!)
                        continuation.resume(returning: decodedResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
