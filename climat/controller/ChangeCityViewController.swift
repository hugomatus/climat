//
//  ChangeCityViewController.swift
//  climat
//
//  Created by Hugo  Matus on 4/21/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
  func userEnteredANewCityName(city: String) 
}

class ChangeCityViewController: UIViewController {
  
  @IBOutlet weak var changeCityTextField: UITextField!
  
  var delegate : ChangeCityDelegate?
  
  @IBAction func getWeatherPressed(_ sender: UIButton) {
    
    let cityName = changeCityTextField.text!
    
    delegate?.userEnteredANewCityName(city: cityName)
    
    self.dismiss(animated: true, completion: nil)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
