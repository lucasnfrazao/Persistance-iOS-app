//
//  CategoryViewController.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 24/09/21.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UIViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    let tableView = UITableView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ToDoListy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedButton(_:)))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        
        loadCategories()

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
    
    @objc func pressedButton(_ sender: UIBarButtonItem) {
        
        var categoryTextField = UITextField()
        var emojiTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { alert in
            
            let newCategory = Category()
            newCategory.name = categoryTextField.text!
            newCategory.emoji = emojiTextField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new Category"
            categoryTextField = alertTextField
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add Emoji"
            emojiTextField = alertTextField
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func save(category: Category) {
        
        do {
            try realm.write{
                realm.add(category)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {

        categories = realm.objects(Category.self)
        
        tableView.reloadData()

    }



}

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let destinationVC = ViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC?.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        cell.title.text = categories?[indexPath.row].name ?? "No Categories Yet"
        cell.emoji.text = categories?[indexPath.row].emoji ?? "🤯"
        
        //cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Yet"
        
        cell.delegate = self
        
        return cell
    }
    
    
}

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let category = self.categories?[indexPath.row] {
               
                do {
                   try self.realm.write {
                        self.realm.delete(category)
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
               
                //self.tableView.reloadData()
            }
            
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash.fill")

        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
}
