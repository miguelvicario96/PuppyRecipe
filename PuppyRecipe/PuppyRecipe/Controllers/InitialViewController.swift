//
//  InitialViewController.swift
//  PuppyRecipe
//
//  Created by Miguel Vicario on 1/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var saucePicker: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saucePicker.delegate = self
        saucePicker.dataSource = self
        
        searchButton.layer.cornerRadius = 10
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Picker.pickerRowSelected = 0
        saucePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    @IBAction func sauceSearch(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "TableSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let option = Picker.pickerData[Picker.pickerRowSelected]
        if segue.identifier == "TableSegue"{
            let view = segue.destination as? ViewController
            view?.ingredientChoosen = option
        }
    }
}

extension InitialViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Picker.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Picker.pickerRowSelected = row
    }
}

extension InitialViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Picker.pickerData.count
    }
    
    

}
