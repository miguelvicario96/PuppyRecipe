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
    
    @IBOutlet weak var titleLabel: UILabel! //Conexión a UILabel
    @IBOutlet weak var ingredientsTextView: UITextView! //Conexión a TextView
    @IBOutlet weak var webButton: UIButton! //Conexión a UIButton
    @IBOutlet weak var webView: WKWebView! //Conexión a WKWebView
    
    //Variables usadas para el paso de información del TextView a este controlador
    var recipeTitle: String!
    var ingredients: String!
    var href: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData() //Llamado a setData()
        
        //Configuración de preferencias del webView
        let webViewPrefs = WKPreferences()
        webViewPrefs.javaScriptEnabled = true
        webViewPrefs.javaScriptCanOpenWindowsAutomatically = true
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.preferences = webViewPrefs
        webView.isHidden = true //  Inicialmente el webView no podrá verse
        
        webButton.layer.cornerRadius = 10 //Cambio al radio del botón
        ingredientsTextView.flashScrollIndicators() //Muestra del scroll del TextView
    }
    
    func setData(){ //Formato de datos a los ingredients devueltos por la URL y su asignación a los views correspondientes
        titleLabel.text = recipeTitle
        //Se cambian las "," por saltos de línea
        let formatIngredient = ingredients.replacingOccurrences(of: ",", with: "\n")
        ingredientsTextView.text = formatIngredient
    }
    
    @IBAction func webAction(_ sender: Any) { //Botón que activa el webView
        webView.isHidden = false //Se muestra el webView
        let myURL = URL(string:href) //Se crea la URL con la información obtenida de "href" en la URL
        let myRequest = URLRequest(url: myURL!) //Se hace el request a la URL
        webView.load(myRequest) //Se carga la pagína en el webView
        //Se le asigna el color blanco de fondo a todo la pantalla para que no se vea mal por el azul de default
        self.view.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }
}
