//
//  ConvertControllerViewController.swift
//  Convertisseur
//
//  Created by Afonso, Nicolas on 31/10/2018.
//  Copyright © 2018 CA Technologies Inc. All rights reserved.
//

import UIKit

class ConvertControllerViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UIView!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var outputView: UIView!
    @IBOutlet weak var outputLabel: UILabel!
    
    // Variables
    var type:String?
    var views :[UIView] = []
    var isSwitched : Bool = false
    
    // Wording
    let eurosW : String = "euros"
    let dollarsW : String = "dollars"
    let celsiusW : String = "celsius"
    let fahrenheitW : String = "fahrenheits"
    let kilometersW : String = "kilomètres"
    let milesW : String = "miles"
    let numberFormat = "%.2f"
    
    
    // Override UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let convertType = type {
        titleLabel.text = "Conversion de \(convertType)"
        
        views = [inputTextField, outputView]
        setCornerRadiusOfViews(radius: 10, viewsArray: views)
        
        
        switch type{
        case DEVISE : setTitleLabel(eurosW, dollarsW) ; todoLabel.text =  isSwitched ? "Entrez la somme à convertir ($)" : "Entrez la somme à convertir (€)"
        case TEMPERATURE : setTitleLabel(celsiusW, fahrenheitW) ; todoLabel.text = isSwitched ? "Entrez la température à convertir (°F)" : "Entrez la température à convertir (°C)"
        case DISTANCE : setTitleLabel(kilometersW, milesW) ;  todoLabel.text = isSwitched ? "Entrez la distance à convertir (miles)" : "Entrez la distance à convertir (kms)"
        default: break
            }
            
        // keyboard auto-hide management
        let tap =  UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        }
        else { dismiss(animated: true, completion: nil) }
    }
    
    
    // Functions
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setCornerRadiusOfViews (radius : Int, viewsArray : [UIView]){
        for v in viewsArray {
            v.layer.cornerRadius = CGFloat(radius)        }
    }
    
    func setTitleLabel ( _ sourceToConvert : String, _ destinationToConvert : String ){
        if !(isSwitched) {
        titleLabel.text = "Conversion de \(sourceToConvert) vers \(destinationToConvert)"
        }
        else {
              titleLabel.text = "Conversion de \(destinationToConvert) vers \(sourceToConvert)"
        }
    }
    
    
    // Compute fonctions
    
    func compute () -> String {
        
        var result = ""
        
        if type != nil, let texte = dataTextField.text, let customerInput = Double(texte)  {
        
        switch type{
            
        case DEVISE : result = isSwitched ? String(format: numberFormat, convertDollarsToEuros(customerInput))+" €" : String(format: numberFormat, convertEurosToDollars(customerInput))+" $"
            
            
        case TEMPERATURE : result = isSwitched ? String(format: numberFormat, convertFahrenheitsToCelsius(customerInput))+" °C" : String(format: numberFormat, convertCelsiusToFahrenheits(customerInput))+" °F"
            
        case DISTANCE : result = isSwitched ? String(format: numberFormat, converMilesToKilometers(customerInput))+" kms" : String(format: numberFormat, convertKilometersToMiles(customerInput))+" mi"
            
        default: break
        }
        }
        
        return result
    }
    
    func convertDollarsToEuros(_ dollars : Double) -> Double
    {
       return dollars * 0.88
    }
    
    func convertEurosToDollars(_ euros : Double) -> Double
    {
        return euros / 0.88
    }
    
    
    func convertFahrenheitsToCelsius (_ fahrenheits : Double) -> Double {
        return (fahrenheits - 32) * 5/9
    }
    
    func convertCelsiusToFahrenheits (_ celsius : Double) -> Double {
      return (celsius * 9/5) + 32
    }
    
    
    func converMilesToKilometers (_ miles : Double) -> Double {
    return miles * 1.609
    }
    
    func convertKilometersToMiles(_ kilometers : Double) -> Double {
        return kilometers / 1.609
    }
    
    
    // Actions
    @IBAction func switchAction(_ sender: Any) {
        isSwitched = !isSwitched
        switch type{
        case DEVISE : setTitleLabel(eurosW, dollarsW); todoLabel.text =  isSwitched ? "Entrez la somme à convertir ($)" : "Entrez la somme à convertir (€)"
        case TEMPERATURE : setTitleLabel(celsiusW, fahrenheitW);todoLabel.text = isSwitched ? "Entrez la température à convertir (°F)" : "Entrez la température à convertir (°C)"
        case DISTANCE : setTitleLabel(kilometersW, milesW); todoLabel.text = isSwitched ? "Entrez la distance à convertir (miles)" : "Entrez la distance à convertir (kms)"
        default: break
        }
        
        outputLabel.text = compute()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updatedTextField(_ sender: UITextField) {
        outputLabel.text = compute()
    }
    
}
