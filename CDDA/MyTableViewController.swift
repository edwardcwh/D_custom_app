//
//  MyTableViewController.swift
//  CDDA
//
//  Created by edwardchong on 25/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        store.fetchData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].value(forKeyPath: "title") as? String
        cell.detailTextLabel?.text = ((list[indexPath.row].value(forKeyPath: "releaseDate") as? String)! + " release")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You choosed \(indexPath.row)")
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        desVC.name = (list[indexPath.row].value(forKeyPath: "title") as? String)!
        desVC.lang = (list[indexPath.row].value(forKeyPath: "language") as? String)!
        desVC.date = (list[indexPath.row].value(forKeyPath: "releaseDate") as? String)!
        desVC.over = (list[indexPath.row].value(forKeyPath: "overview") as? String)!
        desVC.image = UIImage(data: list[indexPath.row].value(forKeyPath: "imageData") as! Data)!
        
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    func refresh(){
        self.tableView.reloadData()
    }

}
