//
//  QiitaSearchViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/10.
//

import Foundation
import UIKit

class QiitaSearchViewController: UIViewController, UISearchBarDelegate, UIAdaptivePresentationControllerDelegate{

    let setWord = Notification.Name("loadItemWithSearchWord")
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let word = searchBar.text else {
            return
        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: setWord.rawValue), object: word)

        self.navigationController?.popViewController(animated: true)
    }

    func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension QiitaSearchViewController :UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
