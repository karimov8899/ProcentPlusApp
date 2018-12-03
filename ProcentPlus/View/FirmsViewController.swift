//
//  FirmsViewController.swift
//  ProcentPlus
//
//  Created by Роман Давыдов on 03.10.2018.
//  Copyright © 2018 Роман Давыдов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct bonuses {
    var percent : String
    var sum_from : Int
    var partner_id : Int
    var sum_to : Any
    var id: Int

}

class FirmsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var firm_details : [UserModel3] = []
    var login_details : [UserModel] = []
    var segueEnabled = 0
    var categoryTitle = ""
    var params : Parameters? = [:]
    var bonus : [bonuses] = []
    var firmTitle = ""
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var titleCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
        
        if categoryTitle == "" {
            titleCategory.text = "Рузультат поиска"
        }
        else {
            titleCategory.text = categoryTitle
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRow = 0
        if segueEnabled == 1 {
            numberRow = login_details.count
        }
        else {
            numberRow = firm_details.count
        }
        return numberRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! CustomTableViewCell
        
        if segueEnabled == 1 {
            cell.label2.text = login_details[indexPath.row].name
        }
        else {
            cell.label2.text = firm_details[indexPath.row].name
        }
        return cell
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segueEnabled == 1 {
            params = [
                "partner_id": login_details[indexPath.row].id
            ]
            firmTitle = login_details[indexPath.row].name
        }
        else {
            params = [
                "partner_id": firm_details[indexPath.row].id
            ]
            firmTitle = firm_details[indexPath.row].name
        }
        findCategory()
        
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    func findCategory() {
        
        
        let head : HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "Token")!
            
        ]
        
        // Параметры запроса
        
        Alamofire.request("http://procentplus.com/api/bonuses/current_bonus", method: .post, parameters: params, encoding: JSONEncoding.default, headers: head).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                
                json["bonus"].forEach({
                    (user) in
                   let user = bonuses(percent: json["bonus"]["percent"].stringValue, sum_from: json["bonus"]["sum_from"].intValue, partner_id: json["bonus"]["partner_id"].intValue, sum_to: json["bonus"]["sum_to"].intValue, id: json["bonus"]["id"].intValue)
                    self.bonus.append(user)
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.performSegue(withIdentifier: "bonusesSegue", sender: self.bonus) 
                        
                    })
                    print(json["bonus"])
                    
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    @objc func rightSwipe(){
        performSegue(withIdentifier: "showCategory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bonusesSegue" {
            let theDestination = (segue.destination as? BonusViewController)
            theDestination?.bonus_details = bonus
            theDestination?.firmTitle = firmTitle
        }
    }

}
