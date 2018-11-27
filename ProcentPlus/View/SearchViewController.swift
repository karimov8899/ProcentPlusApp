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

    
struct UserModel {
    
    var id: Int
    var name: String
    var partnerId : Int
    var city : String
}


    

class SearchViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var sityTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var case3search: UISegmentedControl!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var parameters: Parameters? = [:]
    var usersData : [UserModel] =  []
    
    @IBAction func segmented(_ sender: Any) {
        if (case3search.selectedSegmentIndex == 1) {
            cityLabel.text = "Название"
            addressLabel.isHidden = true
            adressTextField.isHidden = true
        }
        else if (case3search.selectedSegmentIndex == 2) {
            cityLabel.text = "Id"
            addressLabel.isHidden = true
            adressTextField.isHidden = true
        }
        else {
            cityLabel.text = "Город"
            addressLabel.isHidden = false
            adressTextField.isHidden = false
        }
    }
    
    
    
    
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
      print(sityTextField.text!)
        print(adressTextField.text!)
    }
    
    // Поиск по выбранным параметрам
    
    func searching() {
        if (sityTextField.text! == "" && adressTextField.text! == "") {
            let alert = UIAlertController(title: "Ошибка", message: "Незаполнены поля", preferredStyle: .alert)
            let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // Поиск по адресу и городу
            if (case3search.selectedSegmentIndex == 0) {
                if (sityTextField.text! == "" && adressTextField.text! != ""){
                    parameters = [
                        "search_params": [
                            [    "param":  "address",
                                 "value":   adressTextField.text!
                            ]
                        ]
                        
                    ]
                    request()
                }
                else  {
                    parameters = [
                        "search_params": [
                            [    "param":  "city",
                                 "value":   sityTextField.text!
                            ]
                        ]
                        
                    ]
                    request()
                    
                }
                
            }
                
            // Поиск по названию
            else if (case3search.selectedSegmentIndex == 1) {
                
                
                    parameters = [
                        "search_params": [
                            [    "param":  "name",
                                 "value": sityTextField.text!
                            ]
                        ]
                        
                    ]
                    request()
                
                
            }
                
            // Поиск по id
            else {
                parameters = [
                    "search_params": [
                        [    "param":  "id",
                             "value": sityTextField.text!
                        ]
                    ]
                    
                ]
                request()
            }
        }
    }
    
    
    /* struct Post {
        
        var id: Int
        var name: String
        var partnerId : Int
        var city : String
        
        init?(json: [String: Any]) {
            
            guard
                let name = json["name"] as? String,
                let id = json["id"] as? Int,
                let partnerId = json["partner_id"] as? Int,
                let city = json["city"] as? String
                else {
                    return nil
            }
            
            self.name = name
            self.id = id
            self.partnerId = partnerId
            self.city = city
        }
        
        static func getArray(from jsonArray: Any) -> [Post]? {
            
            guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
            var posts: [Post] = []
            
            for jsonObject in jsonArray {
                if let post = Post(json: jsonObject) {
                    posts.append(post)
                }
            }
            return posts
        }
    } */
    
    // Запрос
    func request() {
        // Header запроса
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "Token")!
        
        ]
        
        // Параметры запроса
        
       /* Alamofire.request("http://procentplus.com/api/point_of_sales/search", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: head).responseString{
            (response) in
            guard let statusCode = response.response?.statusCode else { return }
            if (200..<300).contains(statusCode) {
                self.myjson = JSON(response.result.value!)
                DispatchQueue.main.async(execute: { () -> Void in
                    self.performSegue(withIdentifier: "searchSegue", sender: self.myjson)
                })
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность данных", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
            }
        } */
        Alamofire.request("http://procentplus.com/api/point_of_sales/search", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: head).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                json["point_of_sales"].array?.forEach({
                    (user) in
                    let user = UserModel(id: user["id"].intValue, name: user["name"].stringValue,partnerId: user["partner_id"].intValue, city: user["city"].stringValue)
                    self.usersData.append(user)
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.performSegue(withIdentifier: "searchSegue", sender: self.usersData)
                        
                    })
                    print(self.usersData)
                }) 
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // Обновление токена при загрузке
    
    func refresh() {
        let head : HTTPHeaders = [
            "Content-Type":"application/json"]
        let parameters: Parameters = [
            "mobile_user": [
                "email": UserDefaults.standard.string(forKey: "Email")!,
                "password": UserDefaults.standard.string(forKey: "Password")!
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
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let theDestination = (segue.destination as? CategoriesViewController)
            theDestination?.login_details = usersData
        }
        
    }

}
