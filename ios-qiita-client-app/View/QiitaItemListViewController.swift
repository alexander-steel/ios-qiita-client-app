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

    private let notificationCenter = NotificationCenter()
    private var viewModel: QiitaItemListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        Task {
            await self.viewModel.loadQiitaItem()
        }

        settingTableView()
        settingNotificationcenter()
    }
        
    func settingTableView(){
        tableview.refreshControl = UIRefreshControl()
        tableview.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "QiitaItemTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    @objc func refreshTableView() {
        Task {
            await viewModel.loadQiitaItem()
        }

        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.refreshControl?.endRefreshing()
        }
    }
    
    func settingNotificationcenter(){
        notificationCenter.addObserver(self, selector: #selector(loadedQiitaItem(notification:)), name: NSNotification.Name(rawValue: "loadQiitaItem"), object: qiitaItems)
    }
    
    
    ///本当はDIライブラリ使うなりしてDIコンテナに置いたり登録するのが良さそう
    func initializeViewModel(){
        viewModel = QiitaItemListViewModel(with: notificationCenter, usecase: QiitaUsecase(repository: QiitaRepository(apiservice: QiitaApiService())))
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
    
    func segueWebView(index: Int){
        let storyboard = UIStoryboard(name: "QiitaWebView", bundle: nil)
        let qiitaWebView = storyboard.instantiateViewController(withIdentifier: "QiitaWebView") as! QiitaWebViewController
        qiitaWebView.qiitaItem = qiitaItems?[index]
        navigationController?.pushViewController(qiitaWebView, animated: true)
    }
}
