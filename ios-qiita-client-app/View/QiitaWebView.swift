//
//  QiitaWebView.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/09.
//

import Foundation
import UIKit
import WebKit

class QiitaWebView : UIViewController {
   
    var webView: WKWebView!
    var url:URL?
    
    override func loadView() {
        setupWebView()
    }
    
    override func viewDidLoad() {
        loadUrl(url: url ?? URL(string: "https://www.google.com/")!)
    }
    
    func loadUrl(url: URL){
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func setupWebView(){
        let webViewConfig = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        
        webView.uiDelegate = self
        
        webView.navigationDelegate = self
        
        view = webView
    }
}

extension QiitaWebView: WKUIDelegate {
    
}

extension QiitaWebView: WKNavigationDelegate {
    
}
