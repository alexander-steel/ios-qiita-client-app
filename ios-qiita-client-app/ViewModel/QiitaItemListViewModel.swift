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

    init(with notificationCenter: NotificationCenter,
         usecase: QiitaUsecaseProtocol){
        self.notificationCenter = notificationCenter
        self.usecase = usecase
    }

   @objc func loadQiitaItem() async {
        var result: [QiitaItem] = []

        do {
            result = try await usecase.getQiitaItems()
            notificationCenter.post(name: Notification.Name(rawValue: loadItem.rawValue), object: result)
        } catch {
            print(error)
        }
    }
}
