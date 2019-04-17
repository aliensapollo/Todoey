//
//  ViewController.swift
//  Todoey
//
//  Created by DuongHoangNguyen on 16/04/2019.
//  Copyright © 2019 Nguyen Hoang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["A","B","C"]
    
    //dùng userdefauft (1)
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        } //(1)
        
        super.viewDidLoad()
    }

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
        }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true) //hiệu ứng khi click row
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFields = UITextField()
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        alert.addTextField { (Item) in
            Item.placeholder = "New Item"
            textFields = Item
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.itemArray.append(textFields.text!)
            print(self.itemArray)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //(1)
            
            //self.loadView() loadview cũng ok, nghiên cứu sau
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

