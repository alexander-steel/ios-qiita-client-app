//
//  ViewControllerExtension.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/08.
//

import Foundation
import UIKit

protocol ImageByUrlProtocol {
    func getImageByUrl(url: String) -> UIImage
}

extension UIViewController: ImageByUrlProtocol {
    func getImageByUrl(url: String) -> UIImage {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
            return UIImage() ///画像が見つかりませんでした的なのを本来だったら返してあげるのが良さそう
        }
    }
}
