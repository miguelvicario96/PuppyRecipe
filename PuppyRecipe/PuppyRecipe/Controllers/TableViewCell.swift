//
//  TableViewCell.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //Función que nos ayuda a asignar la información que viene del TextView a los views del XIB
    func setData(name: String){
        textLabel?.text = name
    }
    
}
