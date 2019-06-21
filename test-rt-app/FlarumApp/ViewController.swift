//
//  ViewController.swift
//  FlarumApp
//
//  Created by Chamath Palihawadana on 5/24/17.
//  Copyright © 2017 Chamath Palihawadana. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UIWebViewDelegate  {
    
    let notifications = ["Local Notification",
                         "Local Notification with Action",
                         "Local Notification with Content"]
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        webView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let u2 = URL(string: "https://rocketrip.com");
        let u = URLRequest(url: u2!);
        webView.loadRequest(u);
        webView.scrollView.bounces = false;
    }
    func webViewDidFinishLoad(_ webView : UIWebView) {
        hideActivityIndicator()
        let notificationType = notifications[0]
        
        let alert = UIAlertController(title: "",
                                      message: "After 5 seconds " + notificationType + " will appear",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.appDelegate?.scheduleNotification(notificationType: notificationType)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        webView.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height);
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha:0.3)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        activityIndicator.tag = 100 // 100 for example
        
        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        
        view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        
        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()
        
        //UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
}

