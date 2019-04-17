//
//  ViewController.swift
//  Todoey
//
//  Created by DuongHoangNguyen on 16/04/2019.
//  Copyright © 2019 Nguyen Hoang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //dùng userdefauft (1)
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        
        let newItem = Item()
        newItem.tittle = "A"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.tittle = "B"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.tittle = "C"
        itemArray.append(newItem3)
        
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.tittle
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //Thay dòng dưới
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
        }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true) //hiệu ứng khi click row
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //Thay hàng dưới
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        
        tableView.reloadData()
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
            
            let addNewItem = Item()
            addNewItem.tittle = textFields.text!
            self.itemArray.append(addNewItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //(1)
            
            //self.loadView() loadview cũng ok, nghiên cứu sau
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

