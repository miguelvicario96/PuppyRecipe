//
//  Picker.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

class Picker{
    
     /*
 
    Clase creada para controlar la información del PickerView para evitar crear variables
    globales dentro de la clase InitialViewController
 
    */
    
    static let pickerData = ["Onion","Garlic","Onion and Garlic"]//Información del PickerView
    static var pickerRowSelected: Int = 0
    
    /*
 
    pickerRowSelected se inicializa en cero ya que si no se usa el PickerView por querer usar el primer elemento
    dara un error ya que nunca se abra mandado a llamar el Delegate y por tanto el didSelectRow
 
    */
}
