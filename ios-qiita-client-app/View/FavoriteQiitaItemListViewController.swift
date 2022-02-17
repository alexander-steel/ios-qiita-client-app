//
//  FavoriteQiitaItemListViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/15.
//

import Foundation
import UIKit

class FavoriteQiitaItemListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    private var qiitaItems: [QiitaItem]?
    private var viewModel: FavoriteQiitaItemListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        setupNavigationbar()
        settingNotificationcenter()
        self.viewModel.loadFavoriteQiitaItems()
        settingTableView()
    }

    func initializeViewModel() {
        viewModel = FavoriteQiitaItemListViewModel(usecase: QiitaUsecase(repository: QiitaRepository(apiservice: QiitaApiService())))
    }

    func settingTableView() {
        tableview.refreshControl = UIRefreshControl()
        tableview.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "QiitaItemTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    func settingNotificationcenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadedFavoriteQiitaItem(notification:)), name: NSNotification.Name(rawValue: "loadFavoriteQiitaItems"), object: qiitaItems)
    }

    func setupNavigationbar() {
        self.navigationItem.title = "お気に入り記事"
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(self.onClickTrashButtonButton))
        self.navigationItem.rightBarButtonItems = [trashButton]
    }

    @objc func refreshTableView() {
        self.viewModel.loadFavoriteQiitaItems()
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.refreshControl?.endRefreshing()
        }
    }

    @objc func onClickTrashButtonButton() {
        self.viewModel.deleteQiitaItems()
        self.viewModel.loadFavoriteQiitaItems()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

private extension FavoriteQiitaItemListViewController {
    @objc func loadedFavoriteQiitaItem(notification: Notification) {
        guard let qiitaItmes = notification.object as? [QiitaItem] else { return }
        qiitaItems = qiitaItmes
        print(qiitaItmes)
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

extension FavoriteQiitaItemListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return qiitaItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! QiitaItemTableViewCell


        cell.idLabel.text = qiitaItems?[indexPath.row].id ?? "取得できませんでした"
        cell.titleLabel.text = qiitaItems?[indexPath.row].title ?? "取得できませんでした"
        cell.thumbnail.image = getImageByUrl(url: qiitaItems?[indexPath.row].user.thumbnailUrl ?? "https://iphone-mania.jp/uploads/2020/12/google-408194_640-e1607401813476.png")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueWebView(index: indexPath.row)
    }

    func segueWebView(index: Int) {
        let storyboard = UIStoryboard(name: "QiitaWebView", bundle: nil)
        let qiitaWebView = storyboard.instantiateViewController(withIdentifier: "QiitaWebView") as! QiitaWebViewController
        qiitaWebView.qiitaItem = qiitaItems?[index]
        navigationController?.pushViewController(qiitaWebView, animated: true)
    }
}

