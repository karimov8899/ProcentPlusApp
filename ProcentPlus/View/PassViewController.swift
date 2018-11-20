//
//  PassViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 02.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goButton.layer.cornerRadius = 25
        emailTextfield.layer.cornerRadius = 25
        emailTextfield.layer.borderWidth = 1.0;
        emailTextfield.layer.borderColor = UIColor.darkGray.cgColor
        emailTextfield.layer.masksToBounds = true
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
