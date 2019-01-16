//
//  ViewController.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    var ingredientChoosen: String!
    var flag: Int = 1
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        ingredientLabel.text = ingredientChoosen + " Recipes"
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        setData()
        downloadRecipesByIngredient(name: ingredientChoosen)
    }
    
    func setData(){
        
        if ingredientChoosen == "Onion"{
            ingredientChoosen = "onions"
        }
        else if ingredientChoosen == "Onion and Garlic"{
            ingredientChoosen = "onions,garlic"
            flag = 2
        }
        else{
            ingredientChoosen = "garlic"
            flag = 3
        }
    }
    
    func downloadRecipesByIngredient(name: String){
        RecipeService.fecthRecipes(ingredient: name) {(result: [Recipe]) in
            self.recipes = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPathSelected = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "DetailSegue"{
            print(indexPathSelected)
            let detailViewData = segue.destination as? DetailViewController
            let recipeSelected = recipes[indexPathSelected.row]
            detailViewData?.recipeTitle = recipeSelected.title
            detailViewData?.ingredients = recipeSelected.ingredients
            detailViewData?.href = recipeSelected.href
        }
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.setData(name: recipes[indexPath.row].title)
        
        if flag == 1{
            cell.backgroundColor = UIColor(red:0.73, green:0.91, blue:0.89, alpha:0.3)
        }
        else if flag == 2{
            cell.backgroundColor = UIColor(red:0.73, green:0.91, blue:0.76, alpha:0.3)
        }
        else{
            cell.backgroundColor = UIColor(red:0.83, green:0.73, blue:0.91, alpha:0.3)
        }
        
        return cell
    }
}
