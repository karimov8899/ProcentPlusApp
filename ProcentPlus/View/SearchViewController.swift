//
//  SearchViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 03.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SearchViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var sityTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var case3search: UISegmentedControl!
    
    var parameters: Parameters? = [:]
    
    
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
        
        refresh()
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
      searching()
    }
    
    
    func searching() {
        
        if (case3search.selectedSegmentIndex == 0) {
            if (sityTextField.text! != "nil" && adressTextField.text! == "nil" || sityTextField.text! != "nil" && adressTextField.text! != "nil") {
                parameters = [
                    "search_params": [
                    "param": "address",
                    "value": adressTextField.text!
                    ]
                    
                ]
                request()
                
            }
        } else if (case3search.selectedSegmentIndex == 1) {
            
        } else {
            
        }
    }
    // Запрос
    func request() {
        // Header запроса
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Auntification": UserDefaults.standard.string(forKey: "Token")!
        
        ]
        
        // Параметры запроса
        
        Alamofire.request("http://procentplus.com/api/point_of_sales/search", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: head).responseJSON{
            responseJSON in
            guard let statusCode = responseJSON.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                
                print("ureee")
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность данных", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                print(UserDefaults.standard.string(forKey: "Token")!)
                print(self.parameters)
            }
            
        }
    }
    
    func refresh() {
        let head : HTTPHeaders = [
            "Content-Type":"application/json"]
        let parameters: Parameters = [
            "mobile_user": [
                "email": "sohin569@gmail.com",
                "password": "password"
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
                    print(UserDefaults.standard.string(forKey: "Token")!)
                    
                }
                
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте соединение", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: {(handler) in
                    
                URLSessionConfiguration.default.timeoutIntervalForRequest = 30
                self.refresh()
                })
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                
                print("neaa")
            }
            
        }
    }

}
