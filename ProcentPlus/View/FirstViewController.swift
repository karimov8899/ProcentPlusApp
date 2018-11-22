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
    
    
    var newuser: String?
    var token: String?
    
    
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
    @IBAction func login(_ sender: Any) {
        authorize()
    }
    
    func authorize(){
        let head : HTTPHeaders = [
            "Content-Type":"application/json"]
        let parameters: Parameters = [
            "mobile_user": [
              "email": emailTextField?.text!,
              "password": passTextField?.text!
            ]
        ]
        
        let url = URL(string: "http://procentplus.com/api/mobile_users/sign_in")!
        // Both calls are equivalent
        Alamofire.request(url, method: .post, parameters: parameters,  encoding: JSONEncoding.default, headers: head).responseString{
            (response) in
            guard let statusCode = response.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                if let headers = response.response?.allHeaderFields as? [String: String]{
                    let newuser = headers["Authorization"]
                    UserDefaults.standard.set(newuser, forKey: "Token")
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "authorize", sender: self)
                    
                
                }
                
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность данных", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
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
