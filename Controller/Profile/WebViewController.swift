//
//  WebViewController.swift
//  FurEternity
//
//  Created by Saurabh on 01/06/22.
//

import UIKit
import WebKit
class WebViewController: UIViewController , WKUIDelegate,WKNavigationDelegate {

    @IBOutlet weak var heading: CustomLbl!
    @IBOutlet weak var closeBtn: CustomBtn!
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://www.google.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        self.title = "Term and Conditions"
       
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 500, width: 200, height: 200), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
       // self.activityLoader.startAnimating()
       // self.activityLoader.isHidden = false
    }
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
       
       // self.activityLoader.stopAnimating()
       // self.activityLoader.isHidden = true
    }
    
    func webView(_ webView: WKWebView,didFail navigation: WKNavigation! ){
        //self.activityLoader.stopAnimating()
        //self.activityLoader.isHidden = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
