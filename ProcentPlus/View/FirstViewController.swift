//
//  FirstViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 02.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class FirstViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        goButton.layer.cornerRadius = 25
        emailTextField.layer.cornerRadius = 25
        emailTextField.layer.borderWidth = 1.0;
        emailTextField.layer.borderColor = UIColor.darkGray.cgColor
        emailTextField.layer.masksToBounds = true
        
        passTextField.layer.cornerRadius = 25
        passTextField.layer.borderWidth = 1.0;
        passTextField.layer.borderColor = UIColor.darkGray.cgColor
        passTextField.layer.masksToBounds = true

        
       


        // Do any additional setup after loading the view.
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
