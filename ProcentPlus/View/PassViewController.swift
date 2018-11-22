//
//  PassViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 02.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    @IBAction func passSend(_ sender: Any) {
        authorize()
    }
    
    func authorize(){
        let head : HTTPHeaders = [
            "Content-Type":"application/json"]
        let parameters: Parameters = [
            "mobile_user": [
                "email": emailTextfield?.text!
            ]
        ]
        
        let url = URL(string: "http://procentplus.com/api/mobile_users/password")!
        // Both calls are equivalent
        Alamofire.request(url, method: .post, parameters: parameters,  encoding: JSONEncoding.default, headers: head).responseString{
            (response) in
            guard let statusCode = response.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                
                let alert = UIAlertController(title: "Запрос отправлен", message: "Ссылка для восстановления пароля отправлена на вашу почту", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Готово", style: .destructive, handler: {(handler) in
                    self.performSegue(withIdentifier: "passSend" , sender: self)
                })
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте корректность данных", preferredStyle: .alert)
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
