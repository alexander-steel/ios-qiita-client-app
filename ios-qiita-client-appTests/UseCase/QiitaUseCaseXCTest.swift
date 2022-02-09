//
//  QiitaUseCaseXCTest.swift
//  ios-qiita-client-appTests
//
//  Created by steel on 2022/02/07.
//

@testable import ios_qiita_client_app
import XCTest

private func _getQiitaItems() -> [QiitaItem] {
    return [QiitaItem(title: "Vue.js + Flask + MySQL + 各種APIを使った検索アプリ開発", id: "ead8e02f14400a0cfd64", user: User(thumbnailUrl: "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/684296/profile-images/1628501511")), QiitaItem(title: "C言語基礎：並び替え", id: "ead8e02f14400a0cfd64", user: User(thumbnailUrl: "https://avatars.githubusercontent.com/u/88176502?v=4"))]
}

class MockQiitaRepository: QiitaRepositoryProtocol {
    func getQiitaItems() async throws -> [QiitaItem] {
        return _getQiitaItems()
    }
}

class QiitaUseCaseXCTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetQiitaItems() async throws {
        let usecase = QiitaUsecase(repository: MockQiitaRepository())
        let qiitaItem: [QiitaItem] = try await usecase.getQiitaItems()
        XCTAssertEqual(qiitaItem, _getQiitaItems())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
