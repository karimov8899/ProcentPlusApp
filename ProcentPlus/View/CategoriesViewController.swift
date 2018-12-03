//
//  CategoriesViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 03.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct UserModel2 {
    var id: Int
    var name: String
}
struct UserModel3 {
    
    var id: Int
    var name: String
    var activitytypeid : Int
    var city : String
}


class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    var userData : [UserModel2] = []
    var userFirms : [UserModel3] = []
    var parametrs : Parameters = [:]
    var categoryName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
        category()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         
        
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! CustomTableViewCell
        cell.label.text! = userData[indexPath.row].name
        return  cell
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parametrs = [
            "activity_type_id": userData[indexPath.row].id
        ]
        findCategory()
    }
    
    
    
    
    
    func category() {
        // Header запроса
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "Token")!
            
        ]
        
        // Параметры запроса
        
        Alamofire.request("http://procentplus.com/api/activity_types", method: .get, encoding: JSONEncoding.default, headers: head).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                json["activity_types"].array?.forEach({
                    (user) in
                    let user = UserModel2(id: user["id"].intValue, name: user["name"].stringValue)
                    self.userData.append(user)
                    self.tableView.reloadData()
                })
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func findCategory() {
        
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "Token")!
            
        ]
        
        // Параметры запроса
        
        Alamofire.request("http://procentplus.com/api/partners/partners_list", method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: head).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value) :
                let json = JSON(value) 
                json["activity_type"]["partners"].array?.forEach({
                    (user) in
                    let user = UserModel3(id: user["id"].intValue, name: user["name"].stringValue, activitytypeid: user["activity_type_id"].intValue, city: user["city"].stringValue)
                    self.userFirms.append(user)
                    self.categoryName = json["activity_type"]["name"].stringValue
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.performSegue(withIdentifier: "categorySegue", sender: self.userFirms)
                        
                    }) 
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    @objc func rightSwipe(){
        performSegue(withIdentifier: "rightSwipe", sender: nil)
    }
    
    
        
    
   
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categorySegue" {
            let theDestination = (segue.destination as? FirmsViewController)
            theDestination?.firm_details = userFirms
            theDestination?.categoryTitle = categoryName
        }
    }
 

}
