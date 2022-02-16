//
//  QiitaItemListViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import UIKit

class QiitaItemListViewController: UIViewController {
    @IBOutlet var tableview: UITableView!

    private var qiitaItems: [QiitaItem]?
    private var searchWord: String?
    private var viewModel: QiitaItemListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        Task {
            await self.viewModel.loadQiitaItem(word: "")
        }

        setupNavigationBar()
        settingTableView()
        settingNotificationcenter()
    }

    func settingTableView() {
        tableview.refreshControl = UIRefreshControl()
        tableview.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "QiitaItemTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    @objc func refreshTableView() {
        Task {
            await viewModel.loadQiitaItem(word: searchWord ?? "")
        }

        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.refreshControl?.endRefreshing()
        }
    }

    func settingNotificationcenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadedQiitaItem(notification:)), name: NSNotification.Name(rawValue: "loadQiitaItem"), object: qiitaItems)
        NotificationCenter.default.addObserver(self, selector: #selector(loadItemWithSearchWord(notification:)), name: NSNotification.Name(rawValue: "loadItemWithSearchWord"), object: searchWord)
    }

    func setupNavigationBar() {
        let serchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(self.onClickSearchButton))
        self.navigationItem.title = "記事一覧"
        self.navigationItem.rightBarButtonItems = [serchButton]
    }

    @objc func onClickSearchButton() {

        let storyboard = UIStoryboard(name: "QiitaSearchView", bundle: nil)

        let qiitaSearchView = storyboard.instantiateViewController(withIdentifier: "QiitaSearchView") as! QiitaSearchViewController

        self.navigationController?.pushViewController(qiitaSearchView, animated: false)
    }
    
    ///本当はDIライブラリ使うなりしてDIコンテナに置いたり登録するのが良さそう
    func initializeViewModel() {
        viewModel = QiitaItemListViewModel(usecase: QiitaUsecase(repository: QiitaRepository(apiservice: QiitaApiService())))
    }
}

private extension QiitaItemListViewController {
    @objc func loadedQiitaItem(notification: Notification) {
        guard let qiitaItmes = notification.object as? [QiitaItem] else { return }
        qiitaItems = qiitaItmes
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    @objc func loadItemWithSearchWord(notification: Notification) {
        guard let searchWord = notification.object as? String else { return }

        self.searchWord = searchWord

        Task {
            await viewModel.loadQiitaItem(word: self.searchWord ?? "")
        }

        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.refreshControl?.endRefreshing()
        }
    }
}

extension QiitaItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let registerAction = UIContextualAction(style: .normal, title: "お気に入りに追加") { [self] (action, view, completionHandler) in

            self.viewModel.saveFavoriteQiitaItem(qiitaItem: qiitaItems![indexPath.row])

            completionHandler(true)

        }


        let deleteAction = UIContextualAction(style: .destructive, title: "キャンセル") { (action, view, completionHandler) in
              completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction, registerAction])
    }
    
    func segueWebView(index: Int) {
        let storyboard = UIStoryboard(name: "QiitaWebView", bundle: nil)
        let qiitaWebView = storyboard.instantiateViewController(withIdentifier: "QiitaWebView") as! QiitaWebViewController
        qiitaWebView.qiitaItem = qiitaItems?[index]
        navigationController?.pushViewController(qiitaWebView, animated: true)
    }
}
