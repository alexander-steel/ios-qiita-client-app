//
//  QiitaItemListViewModel.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import Foundation
import UIKit

final class QiitaItemListViewModel {

    let loadItem = Notification.Name("loadQiitaItem")
    private let notificationCenter: NotificationCenter
    private let usecase: QiitaUsecaseProtocol

    init(notificationCenter: NotificationCenter,
         usecase: QiitaUsecaseProtocol = QiitaUsecase(repository: QiitaRepository(apiservice: QiitaApiService()))) {
        self.notificationCenter = notificationCenter
        self.usecase = usecase
    }

    
    func loadQiitaItem() async throws {
        var result: [QiitaItem] = []
        
        do {
            result = try await usecase.getQiitaItems()
            notificationCenter.post(name: Notification.Name(rawValue: "loadQiitaItem"),object: result)
        } catch {
            print(error)
        }
    }
}
