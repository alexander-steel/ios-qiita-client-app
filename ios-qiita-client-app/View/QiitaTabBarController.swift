//
//  QiitaTabBarController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/15.
//

import UIKit

class QiitaTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    func setupTab(){
        let qiitaItemListViewController = UIStoryboard(name: "QiitaItemListView", bundle: Bundle.main).instantiateViewController(withIdentifier: "QiitaListView") as! QiitaItemListViewController

        qiitaItemListViewController.tabBarItem = UITabBarItem(title: "itemList", image: .actions, tag: 0)

        let favoriteQiitaItemListViewController = FavoriteQiitaItemListViewController()

        favoriteQiitaItemListViewController.tabBarItem = UITabBarItem(title: "favorite", image: .strokedCheckmark, tag: 0)

        viewControllers = [qiitaItemListViewController, favoriteQiitaItemListViewController].map{ UINavigationController(rootViewController: $0)}

        setViewControllers(viewControllers, animated: true)
    }
}
