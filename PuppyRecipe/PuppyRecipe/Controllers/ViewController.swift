//
//  ViewController.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView! //Conexión al TableView
    @IBOutlet weak var ingredientLabel: UILabel! //Conexión al Label
    
    var ingredientChoosen: String! //Variable usada para el paso de información proveniente de InitialViewController
    var flag: Int = 1 //Bandera usada para saber de que color deberan ser pintadas las filas del TableView
    var recipes: [Recipe] = []  //Array de Recipes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self //tableView conformara el protocolo UITableViewDataSource
        tableView.delegate = self //saucePicker conformara el protocolo UITableViewDelegate
        
        ingredientLabel.text = ingredientChoosen + " Recipes" //Agrega "Recipes" al final de la cadena
        
        //Registo del XIB usado como celda del TableView
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        setData() //Manda a llamar setData
        
        //Manda a llamar downloadRecipesByIngredient y le pasa la variable ingredientChoosen
        downloadRecipesByIngredient(ingredient: ingredientChoosen)
    }
    
    //Función que a partir de la variable ingredientChoosen nos da una cadena apropiada para la busqueda en la URL
    func setData(){
        
        if ingredientChoosen == "Onion"{
            ingredientChoosen = "onions"
        }
        else if ingredientChoosen == "Onion and Garlic"{
            ingredientChoosen = "onions,garlic"
            flag = 2 // 2 si es que se selecciono la opción "Onion and Garlic" del PickerView
        }
        else{
            ingredientChoosen = "garlic"
            flag = 3 // 2 si es que se selecciono la opción "Garlic" del PickerView
        }
    }
    
    //Función que busca en la URL de acuerdo al elemento seleccionado en el PickerView
    func downloadRecipesByIngredient(ingredient: String){
        RecipeService.fecthRecipes(ingredient: ingredient) {(result: [Recipe]) in
            self.recipes = result
            DispatchQueue.main.async {
                self.tableView.reloadData() //Recarga los datos al TableView
            }
        }
    }
}

extension ViewController: UITableViewDelegate{ //Delegate nos avisa si es que el view fue usado
    
    //Función que devuelve la celda seleccionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true) //Nos deselecciona una celda presionada anteriormente
    }
    
    /*
     
     Esta función me permite cambiar la forma en que se va a realizar el segue, en este caso mandando información
     de este Controller al siguiente.
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPathSelected = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "DetailSegue"{ //Comprueba que el segue sea el correcto
            //La variable detailViewData obtiene información de DetailViewController
            let detailViewData = segue.destination as? DetailViewController
            let recipeSelected = recipes[indexPathSelected.row]
            //Paso de información local a las variables de DetailViewController
            detailViewData?.recipeTitle = recipeSelected.title
            detailViewData?.ingredients = recipeSelected.ingredients
            detailViewData?.href = recipeSelected.href

        }
    }
}

extension ViewController: UITableViewDataSource{ //DataSource nos ayuda a darle información al view
    
    //Función que devuelve el número de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    //Función que nos permite dar información a cada una de las filas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Registramos a la variable cell la celda con el identificador TableViewCell (XIB)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //Función dentro de TableViewCell que nos ayuda a dar información a sus views
        cell.setData(name: recipes[indexPath.row].title)
        
        if flag == 1{ //Onion seleccionado en el PickerView
            cell.backgroundColor = UIColor(red:0.73, green:0.91, blue:0.89, alpha:0.3) //Color AZUL
        }
        else if flag == 2{ //Garlic seleccionado en el PickerView
            cell.backgroundColor = UIColor(red:0.73, green:0.91, blue:0.76, alpha:0.3) //Color MORADO
        }
        else{ //Onion and Garlic seleccionado en el PickerView
            cell.backgroundColor = UIColor(red:0.83, green:0.73, blue:0.91, alpha:0.3) //Color VERDE
        }
        
        return cell //Devuelve la celda
    }
}
