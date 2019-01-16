//
//  InitialViewController.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var saucePicker: UIPickerView! //Conexión a PickerView
    @IBOutlet weak var searchButton: UIButton! //Conexión a UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saucePicker.delegate = self //saucePicker conformara el protocolo UIPickerViewDelegate
        saucePicker.dataSource = self //saucePicker conformara el protocolo UIPickerViewDataSource
        
        searchButton.layer.cornerRadius = 10 //Cambio al radio del botón
    }
    
    /*
 
    Función que me permitirá reiniciar los elementos con los que trabaja la vista. Que el PickerView vuelva seleccionar
    el primer elemento y que la variable que almacena la fila seleccionada regrese a cero
     
    */
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        
        Picker.pickerRowSelected = 0
        saucePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    
    @IBAction func sauceSearch(_ sender: UIButton) { //Botón que hace el segue al TableView
        
        self.performSegue(withIdentifier: "TableSegue", sender: self)
    }
    
    /*
     
     Esta función me permite cambiar la forma en que se va a realizar el segue, en este caso mandando información
     de este Controller al siguiente.
 
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let option = Picker.pickerData[Picker.pickerRowSelected]
        if segue.identifier == "TableSegue"{ //Comprueba que el segue sea el correcto
            let view = segue.destination as? ViewController //La variable view obtiene información de ViewController
            //Paso de información local (option) a la variable del ViewController (ingredientChoosen)
            view?.ingredientChoosen = option
        }
    }
}

extension InitialViewController: UIPickerViewDelegate{ //Delegate nos avisa si es que el view fue usado
    
    //Función que devuelve el nombre de cada fila
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Picker.pickerData[row]
    }
    
    //Función que nos indica que fila del PickerView fue seleccionada
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Picker.pickerRowSelected = row
    }
}

extension InitialViewController: UIPickerViewDataSource{ //DataSource nos ayuda a darle información al view
    
    //Función a la que le daremos el número de la cantidad de columnas que queremos para el PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Función que devuelve el número de filas que tendra el PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Picker.pickerData.count
    }
}
