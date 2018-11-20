//
//  SearchViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 03.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var sityTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var case3search: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goButton.layer.cornerRadius = 25
        
        sityTextField.layer.cornerRadius = 25
        sityTextField.layer.borderWidth = 1.0;
        sityTextField.layer.borderColor = UIColor.darkGray.cgColor
        sityTextField.layer.masksToBounds = true
        
        adressTextField.layer.cornerRadius = 25
        adressTextField.layer.borderWidth = 1.0;
        adressTextField.layer.borderColor = UIColor.darkGray.cgColor
        adressTextField.layer.masksToBounds = true
        
        //case3search.layer.backgroundColor = UIColor.red.cgColor
        case3search.layer.cornerRadius = 15
        case3search.layer.borderWidth = 1.0;
        case3search.layer.borderColor = UIColor.red.cgColor
        case3search.layer.masksToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
