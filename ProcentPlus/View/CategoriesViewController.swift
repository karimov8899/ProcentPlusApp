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

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var login_details : [UserModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.login_details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! CustomTableViewCell
        
       // let text = data[indexPath.row]
       cell.label.text! = login_details[indexPath.row].name
        
        return cell
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    @objc func rightSwipe(){
        performSegue(withIdentifier: "rightSwipe", sender: nil)
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
