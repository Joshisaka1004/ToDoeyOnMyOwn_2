//
//  ViewController.swift
//  ToDoeyOnMyOwn_2
//
//  Created by Joachim Vetter on 01.01.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import UIKit

class MyTableVC: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myObj1.myPuzzleFamilies = defaults.array(forKey: "myToDoList") as? [String] ?? myObj1.myPuzzleFamilies
        myObj1.checked = defaults.array(forKey: "myToDoList") as? [Bool] ?? myObj1.checked
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myObj1.myPuzzleFamilies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCells", for: indexPath)
        myCell.textLabel?.text = myObj1.myPuzzleFamilies[indexPath.row]
        if !myObj1.checked[indexPath.row] {
            myCell.accessoryType = .none
        } else {
            myCell.accessoryType = .checkmark
        }
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        if !myObj1.checked[indexPath.row] {
            selectedCell?.accessoryType = .checkmark
            myObj1.checked[indexPath.row] = true
        } else {
            selectedCell?.accessoryType = .none
            myObj1.checked[indexPath.row] = false
        }
        self.defaults.set(myObj1.checked, forKey: "myToDoList")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func myAddButton(_ sender: UIBarButtonItem) {
        
        var myRealTextField = UITextField()
        
        let myAlertVC = UIAlertController(title: "Add Puzzle", message: "", preferredStyle: .alert)
        let myAlertAction = UIAlertAction(title: "we have added your request!", style: .default) { (action) in
            
            if myRealTextField.text != "" {
                myObj1.myPuzzleFamilies.append(myRealTextField.text!)
                myObj1.checked.append(false)
            }
            self.defaults.set(myObj1.myPuzzleFamilies, forKey: "myToDoList")
            self.defaults.set(myObj1.checked, forKey: "myToDoList")
            self.tableView.reloadData()
        }
        myAlertVC.addTextField { (myTextField) in
            myTextField.placeholder = "Give your wish"
            myRealTextField = myTextField
        }
        
        myAlertVC.addAction(myAlertAction)
        present(myAlertVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelAll(_ sender: UIBarButtonItem) {
        myObj1.checked = Array(repeating: false, count: myObj1.checked.count)
        self.tableView.reloadData()
        defaults.removeObject(forKey: "myToDoList")
    }
    
}

