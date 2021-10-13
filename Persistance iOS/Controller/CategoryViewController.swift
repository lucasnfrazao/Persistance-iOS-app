//
//  CategoryViewController.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 24/09/21.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {

    var categories = [Category]()
    
    let tableView = UITableView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ToDoListy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedButton(_:)))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        
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
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { alert in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func saveCategory() {
        
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        }
        catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }



}

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let destinationVC = ViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC?.selectedCategory = categories[indexPath.row]
        }
        
    }
    
}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell

        cell.title.text = categories[indexPath.row].name
        
        return cell
    }
    
    
}
