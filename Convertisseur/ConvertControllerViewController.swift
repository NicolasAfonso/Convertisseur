//
//  ConvertControllerViewController.swift
//  Convertisseur
//
//  Created by Afonso, Nicolas on 31/10/2018.
//  Copyright © 2018 CA Technologies Inc. All rights reserved.
//

import UIKit

class ConvertControllerViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UIView!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var outputView: UIView!
    @IBOutlet weak var outputLabel: UILabel!
    
    var type:String?
    var views :[UIView] = []
    var isSwitched : Bool = false
    
    // Wording
    let eurosW : String = "euros"
    let dollarsW : String = "dollars"
    let celciusW : String = "celcius"
    let fahrenheitW : String = "fahrenheits"
    let kilometersW : String = "kilomètres"
    let milesW : String = "miles"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let convertType = type {
        titleLabel.text = "Conversion de \(convertType)"
        
        views = [inputTextField, outputView]
        setCornerRadiusOfViews(radius: 10, viewsArray: views)
        
        switch type{
        case DEVISE : setTitleLabel(eurosW, dollarsW) ; todoLabel.text = "Entrez la somme à convertir"
        case TEMPERATURE : setTitleLabel(celciusW, fahrenheitW) ; todoLabel.text = "Entrez la température à convertir"
        case DISTANCE : setTitleLabel(kilometersW, milesW) ;  todoLabel.text = "Entrez la distance à convertir"
        default: break
            }
            
            
            let tap =  UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tap)
        }
        else { dismiss(animated: true, completion: nil) }
    }
    
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
    

    @IBAction func switchAction(_ sender: Any) {
        isSwitched = !isSwitched
        switch type{
        case DEVISE : setTitleLabel(eurosW, dollarsW)
        case TEMPERATURE : setTitleLabel(celciusW, fahrenheitW)
        case DISTANCE : setTitleLabel(kilometersW, milesW)
        default: break
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func updatedTextField(_ sender: UITextField) {
    }
    
}
