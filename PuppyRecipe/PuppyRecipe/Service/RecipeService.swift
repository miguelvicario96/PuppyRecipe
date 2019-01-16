//
//  RecipeService.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

class RecipeService{
    
    static var urlSession = URLSession(configuration: .default)
    
    static func fecthRecipes(ingredient: String = "onions", onSuccess: @escaping ([Recipe]) -> Void){
        let url = URL(string: "http://www.recipepuppy.com/api/?i=\(ingredient)&q=sauce&p=3")
        
        let dataTask = urlSession.dataTask(with: url!){data, response, error in
            if error == nil{
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
                if statusCode == 200{
                    guard let json = parseData(data: data!) else {return}
                    let recipes = recipesFrom(json: json)
                    onSuccess(recipes)
                }
            }
        }
        dataTask.resume()
    }
    
    static func parseData(data: Data) -> NSDictionary?{
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        return json
    }
    
    static func recipesFrom(json: NSDictionary) -> [Recipe]{
        let results = json["results"] as! [NSDictionary]
        var recipes: [Recipe] = []
        for dataResults in results{
            let recipe = Recipe.create(dict: dataResults)
            recipes.append(recipe!)
        }
        return recipes
    }
}
