//
//  FavoriteQiitaItemListViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/15.
//

import Foundation
import UIKit

class FavoriteQiitaItemListViewController: UIViewController {
    private var viewModel: QiitaItemListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoriteQiitaItemListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! QiitaItemTableViewCell

        /*
        cell.idLabel.text = qiitaItems?[indexPath.row].id ?? "取得できませんでした"
        cell.titleLabel.text = qiitaItems?[indexPath.row].title ?? "取得できませんでした"
        cell.thumbnail.image = getImageByUrl(url: qiitaItems?[indexPath.row].user.thumbnailUrl ?? "https://iphone-mania.jp/uploads/2020/12/google-408194_640-e1607401813476.png")
         */

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueWebView(index: indexPath.row)
    }

    func segueWebView(index: Int) {
        let storyboard = UIStoryboard(name: "QiitaWebView", bundle: nil)
        let qiitaWebView = storyboard.instantiateViewController(withIdentifier: "QiitaWebView") as! QiitaWebViewController
        //qiitaWebView.qiitaItem = qiitaItems?[index]
        navigationController?.pushViewController(qiitaWebView, animated: true)
    }
}

