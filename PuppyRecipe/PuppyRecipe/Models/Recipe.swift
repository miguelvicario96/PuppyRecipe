//
//  Recipe.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

struct Recipe{
    var title: String
    var href: String
    var ingredients: String
    var thumbnail: String
    
    static func create(dict: NSDictionary) -> Recipe?{
        guard let title = dict["title"] as? String,
            let href = dict["href"] as? String,
            let ingredients = dict["ingredients"] as? String,
            let thumbnail = dict["thumbnail"] as? String else{
                return nil
        }
        return Recipe(title: title, href: href, ingredients: ingredients, thumbnail: thumbnail)
    }
}
