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
    private lazy var viewModel = QiitaItemListViewModel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()

        detach { [weak self] in
            try await self?.viewModel.loadQiitaItem()
        }

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "QiitaItemTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        notificationCenter.addObserver(self, selector: #selector(loadQiitaItem(notification:)), name: NSNotification.Name(rawValue: "loadQiitaItem"), object: qiitaItems)
    }
}

private extension QiitaItemListViewController {
    @objc func loadQiitaItem(notification: Notification) {
        guard let qiitaItmes = notification.object as? [QiitaItem] else { return }
        qiitaItems = qiitaItmes
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    func getImageByUrl(url: String) -> UIImage {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
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
}
