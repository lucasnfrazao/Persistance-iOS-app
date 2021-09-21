//
//  ViewController.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 20/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let itemArray = ["Chocolate", "Coffee", "Bread"]
    
    let toDoListView = ToDoListView()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "ToDoListy"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        
        cell.title.text = itemArray[indexPath.row]

        return cell
    }


}

