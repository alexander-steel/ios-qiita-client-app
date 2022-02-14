//
//  QiitaSearchViewController.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/10.
//

import Foundation
import UIKit

class QiitaSearchViewController: UIViewController, UISearchBarDelegate, UIAdaptivePresentationControllerDelegate{

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let word = searchBar.text {
            
        }
    }

    func setupSearchBar(){
        searchBar.delegate = self
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {

        let qiitaListView = presentationController.presentingViewController as! QiitaItemListViewController
            
        }
}

extension QiitaSearchViewController :UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
