//
//  BonusViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 03.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BonusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        // Do any additional setup after loading the view.
    }
    
    // Запрос
    func request() {
        // Header запроса
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "Token")!
            
        ]
        let parameters: Parameters = [
             "partner_id": 168
        ]
        // Параметры запроса
        
        Alamofire.request("http://procentplus.com/api/bonuses/current_bonus", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: head).responseString{
            (response) in
            print(response)
            guard let statusCode = response.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                
                print(response)
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность данных", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                print(response)
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
