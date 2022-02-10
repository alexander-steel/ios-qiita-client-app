//
//  QiitaRepositoryXCTest.swift
//  ios-qiita-client-appTests
//
//  Created by steel on 2022/02/07.
//

@testable import ios_qiita_client_app
import XCTest

class MockQiitaApiService: QiitaApiServiceProtocol {
    let json = """
    [
        {
            "rendered_body": "rendered_body",
            "coediting": false,
            "comments_count": 0,
            "created_at": "2022-02-04T15:21:48+09:00",
            "group": null,
            "id": "74a8fc43fa7286973141",
            "likes_count": 0,
            "private": false,
            "reactions_count": 0,
            "tags": [
                {
                    "name": "Python",
                    "versions": []
                },
                {
                    "name": "MySQL",
                    "versions": []
                },
                {
                    "name": "Flask",
                    "versions": []
                },
                {
                    "name": "api",
                    "versions": []
                },
                {
                    "name": "Vue.js",
                    "versions": []
                }
            ],
            "title": "Vue.js + Flask + MySQL + 各種APIを使った検索アプリ開発",
            "updated_at": "2022-02-04T15:21:48+09:00",
            "url": "https://qiita.com/peartrees/items/74a8fc43fa7286973141",
            "user": {
                "description": "情報系専攻のB3です",
                "facebook_id": "",
                "followees_count": 3,
                "followers_count": 3,
                "github_login_name": "peartrees",
                "id": "peartrees",
                "items_count": 6,
                "linkedin_id": "",
                "location": "Kobe, Japan",
                "name": "peartrees",
                "organization": "",
                "permanent_id": 684296,
                "profile_image_url": "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/684296/profile-images/1628501511",
                "team_only": false,
                "twitter_screen_name": "apl__lpa",
                "website_url": ""
            },
            "page_views_count": null,
            "team_membership": null
        },
    {
            "rendered_body": "rendered_body",
            "body": "###はじめに",
            "coediting": false,
            "comments_count": 0,
            "created_at": "2022-02-04T15:13:43+09:00",
            "group": null,
            "id": "ead8e02f14400a0cfd64",
            "likes_count": 0,
            "private": false,
            "reactions_count": 0,
            "tags": [
                {
                    "name": "C",
                    "versions": []
                },
                {
                    "name": "初級",
                    "versions": []
                },
                {
                    "name": "ソート",
                    "versions": []
                }
            ],
            "title": "C言語基礎：並び替え",
            "updated_at": "2022-02-04T15:13:43+09:00",
            "url": "https://qiita.com/kidenkadenyorozuya/items/ead8e02f14400a0cfd64",
            "user": {
                "description": null,
                "facebook_id": null,
                "followees_count": 1,
                "followers_count": 0,
                "github_login_name": "kidenkadenyorozuya",
                "id": "kidenkadenyorozuya",
                "items_count": 34,
                "linkedin_id": null,
                "location": null,
                "name": "",
                "organization": null,
                "permanent_id": 2479673,
                "profile_image_url": "https://avatars.githubusercontent.com/u/88176502?v=4",
                "team_only": false,
                "twitter_screen_name": null,
                "website_url": null
            },
            "page_views_count": null,
            "team_membership": null
        }
    ]
    """.data(using: .utf8)!

    func getQiitaItems() async throws -> [QiitaItem] {
        let item: [QiitaItem] = try! JSONDecoder().decode([QiitaItem].self, from: json)
        return item
    }
}

class QiitaRepositoryXCTest: XCTestCase {
    let repository: QiitaRepository = .init(apiservice: MockQiitaApiService())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetQiitaItems() async throws {
        let mockItems = [QiitaItem(title: "Vue.js + Flask + MySQL + 各種APIを使った検索アプリ開発", id: "ead8e02f14400a0cfd64", url: "https://qiita.com/peartrees/items/74a8fc43fa7286973141", user: User(thumbnailUrl: "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/684296/profile-images/1628501511")), QiitaItem(title: "C言語基礎：並び替え", id: "ead8e02f14400a0cfd64", url: "https://qiita.com/kidenkadenyorozuya/items/ead8e02f14400a0cfd64", user: User(thumbnailUrl: "https://avatars.githubusercontent.com/u/88176502?v=4"))]

        let qiitaItems = try await repository.getQiitaItems()
        XCTAssertEqual(qiitaItems, mockItems)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
