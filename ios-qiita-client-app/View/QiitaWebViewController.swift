//
//  QiitaWebView.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/09.
//

import Foundation
import UIKit
import WebKit

class QiitaWebViewController : UIViewController, UINavigationBarDelegate {
        
    var webView: WKWebView!
    
    var qiitaItem: QiitaItem?
    
    override func loadView() {
        setupWebView()
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        loadUrl(url: URL(string: qiitaItem?.url ?? "https://qiita.com/")!)
    }
    
    func loadUrl(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func setupWebView() {
        let webViewConfig = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        
        webView.uiDelegate = self
        
        webView.navigationDelegate = self
        
        view = webView
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = qiitaItem?.title ?? ""
        // iOS15ではNavigationBarのレンダリング方法が変わっていた・・・。
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            // Configure additional customizations here
            self.navigationController?.navigationBar.standardAppearance
            = navigationBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance =
            navigationBarAppearance
        }
    }
}

extension QiitaWebViewController: WKUIDelegate {
    
}

extension QiitaWebViewController: WKNavigationDelegate {
    
}
