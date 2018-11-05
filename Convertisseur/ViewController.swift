//
//  ViewController.swift
//  Convertisseur
//
//  Created by Afonso, Nicolas on 31/10/2018.
//  Copyright © 2018 CA Technologies Inc. All rights reserved.
//

import UIKit

let DEVISE = "Devise"
let TEMPERATURE = "Température"
let DISTANCE = "Distance"

class ViewController: UIViewController {
    
    
    @IBOutlet weak var deviseView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    var views : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        views = [deviseView, distanceView, temperatureView]
        setCornerRadiusOfViews(radius: 10, viewsArray: views)
            }
    
    
    func setCornerRadiusOfViews (radius : Int, viewsArray : [UIView]){
        for v in viewsArray {
            v.layer.cornerRadius = CGFloat(radius)        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as? ConvertControllerViewController{
               convertController.type = sender as? String
            }
        }
    }


    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
            case 0: performSegue(withIdentifier: segueID, sender: DEVISE)
            case 1: performSegue(withIdentifier: segueID, sender: DISTANCE)
            case 2: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default: break
        }
    }
}

