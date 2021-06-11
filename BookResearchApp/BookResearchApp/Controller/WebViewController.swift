//
//  WebViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/10.
//

import UIKit
import WebKit
import PKHUD

class WebViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    //受け取り用の変数
    var amazonURL:String = ""
    var rakutenBooksURL:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if amazonURL != ""
        {
            let amazonReq = URLRequest(url: URL(string:amazonURL)!)
            webView.load(amazonReq)
        }
        else if rakutenBooksURL != ""
        {
            let rakutenBooksURLEncoding = rakutenBooksURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let rakutenBooksReq = URLRequest(url: URL(string:rakutenBooksURLEncoding)!)
            webView.load(rakutenBooksReq)
        }
        else
        {
            print("エラー")
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        HUD.dimsBackground = true
        HUD.show(.progress)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        HUD.hide()
    }
    
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
