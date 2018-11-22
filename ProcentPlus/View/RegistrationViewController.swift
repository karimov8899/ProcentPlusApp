//
//  RegistrationViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 02.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController {
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var pass2TextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        // Do any additional setup after loading the view.
        goButton.layer.cornerRadius = 25
        
        emailTextField.layer.cornerRadius = 25
        emailTextField.layer.borderWidth = 1.0;
        emailTextField.layer.borderColor = UIColor.darkGray.cgColor
        emailTextField.layer.masksToBounds = true
        
        cityTextField.layer.cornerRadius = 25
        cityTextField.layer.borderWidth = 1.0;
        cityTextField.layer.borderColor = UIColor.darkGray.cgColor
        cityTextField.layer.masksToBounds = true
        
        pass1TextField.layer.cornerRadius = 25
        pass1TextField.layer.borderWidth = 1.0;
        pass1TextField.layer.borderColor = UIColor.darkGray.cgColor
        pass1TextField.layer.masksToBounds = true
        
        pass2TextField.layer.cornerRadius = 25
        pass2TextField.layer.borderWidth = 1.0;
        pass2TextField.layer.borderColor = UIColor.darkGray.cgColor
        pass2TextField.layer.masksToBounds = true
    }
    
    @IBAction func register(_ sender: Any) {
        makerequest()
    }
    
    // Функция валидации Email
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // Запрос на регистрацию пользователя
    
    func makerequest() {
        
        // Header запроса
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json"]
        
        // Параметры запроса
        
        let parameters: Parameters = [
            "mobile_user": [
                "email" : emailTextField?.text!,
                "password" : pass1TextField?.text!,
                "city": cityTextField?.text!
            ]
        ]
 
        // Валидация полей
        
        if isValidEmail(testStr: emailTextField.text!) == false{
            
            let alert = UIAlertController(title: "Ошибка регистрации", message: "Неверный формать Email", preferredStyle: .alert)
            let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
            
        } else if cityTextField.text == "" {
            
            let alert = UIAlertController(title: "Ошибка регистрации", message: "Поле город не заполнено", preferredStyle: .alert)
            let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
            
        } else if  pass1TextField.text!.count < 6 || pass2TextField.text!.count < 6 {
            
            let alert = UIAlertController(title: "Ошибка регистрации", message: "Пароль должен содержать не менее шести символов", preferredStyle: .alert)
            let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
            
        }   else if pass1TextField.text! != pass2TextField.text! {
            
            let alert = UIAlertController(title: "Ошибка регистрации", message: "Пароли не совпадают", preferredStyle: .alert)
            let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            // Запрос после валидации всех полей
            
            Alamofire.request("http://procentplus.com/api/mobile_users", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: head).responseString{
            responseJSON in
            guard let statusCode = responseJSON.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                
                self.performSegue(withIdentifier: "regcomplete", sender: self)
                
            } else {
                
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Проверьте корректность данных", preferredStyle: .alert)
                let alertaction =  UIAlertAction(title: "Проверить", style: .destructive, handler: nil)
                alert.addAction(alertaction)
                self.present(alert, animated: true, completion: nil)
                
            }
           
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
