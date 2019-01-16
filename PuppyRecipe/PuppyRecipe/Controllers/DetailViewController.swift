//
//  DetailViewController.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var recipeTitle: String!
    var ingredients: String!
    var href: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        
        let webViewPrefs = WKPreferences()
        webViewPrefs.javaScriptEnabled = true
        webViewPrefs.javaScriptCanOpenWindowsAutomatically = true
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.preferences = webViewPrefs
        webView.isHidden = true
        
        webButton.layer.cornerRadius = 10
        ingredientsTextView.flashScrollIndicators()
    }
    
    func setData(){
        titleLabel.text = recipeTitle
        
        let formatIngredient = ingredients.replacingOccurrences(of: ",", with: "\n")
        print(formatIngredient)
        ingredientsTextView.text = formatIngredient
    }
    
    @IBAction func webAction(_ sender: Any) {
        webView.isHidden = false
        let myURL = URL(string:href)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.view.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }
}
