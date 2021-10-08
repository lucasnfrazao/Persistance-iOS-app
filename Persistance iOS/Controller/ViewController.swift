//
//  ViewController.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 20/09/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var itemArray: [Item] = []

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let toDoListView = ToDoListView()
    
    let tableView = UITableView()
    
    private var search = UISearchController(searchResultsController: nil)
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        loadItems()
        
        navigationItem.title = "ToDoListy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedButton(_:)))
        
        search.searchBar.delegate = self
        
        search.searchBar.placeholder = "Find Tasks"
        self.navigationItem.searchController = search
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        
    }
    
    @objc func pressedButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { alert in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }

    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let item = itemArray[indexPath.row]

        item.done = !item.done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        
        let item = itemArray[indexPath.row]
        
        cell.title.text = item.title
        
        //Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    
    func saveItems() {
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }

}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",  searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
    }
    
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",  searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
        
    }
    
}
