//
//  QiitaItemTest.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/04.
//
//

@testable import ios_qiita_client_app
import Nimble
import Quick

class QiitaItemTest: QuickSpec {
    override func spec() {
        describe("Parse Qiita Item API") {
            it("success") {
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

                let item: [QiitaItem] = try! JSONDecoder().decode([QiitaItem].self, from: json)

                expect(item[0].title).to(equal("Vue.js + Flask + MySQL + 各種APIを使った検索アプリ開発"), description: "is it right title")
                expect(item[0].id).to(equal("74a8fc43fa7286973141"), description: "is it right id")
                expect(item[0].user.thumbnailUrl).to(equal("https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/684296/profile-images/1628501511"), description: "is it right thumbnailUrl")

                expect(item[1].title).to(equal("C言語基礎：並び替え"), description: "is it right title")
                expect(item[1].id).to(equal("ead8e02f14400a0cfd64"), description: "is it right id")
                expect(item[1].user.thumbnailUrl).to(equal("https://avatars.githubusercontent.com/u/88176502?v=4"), description: "is it right thumbnailUrl")
            }
        }
    }
}
