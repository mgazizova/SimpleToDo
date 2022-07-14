//
//  ToDoViewController.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 16.02.2022.
//

import UIKit


class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabelView: UITableView!
    
    @IBAction func cancel(segue:UIStoryboardSegue) { }
    
    private let itemsKey = "items"
    private var changingItemIndex = 0
    var items: [Item] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = getItems()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.allowsMultipleSelection = true
    }

    @IBAction func done(segue:UIStoryboardSegue) {
        if let toDoVC = segue.source as? AddToDoViewController {
            items.append(Item(text: toDoVC.getItemText()))
            items.sort(by: {$1.checked && !$0.checked})
            saveItems()
            tabelView.reloadData()
        }
    }
    
    @IBAction func editDone(segue:UIStoryboardSegue) {
        if let toDoVC = segue.source as? EditToDoViewController {
            items[toDoVC.getIndex()].text = toDoVC.getEditedItem()
            saveItems()
            tabelView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDoneSegue" {
            if let destination = segue.destination as? EditToDoViewController {
                destination.edit(index: changingItemIndex, item: items[changingItemIndex].text)
            }
        }
    }
}

extension ToDoViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath) as! ToDoItemCell
        cell.label.text = items[indexPath.row].text
        items[indexPath.row].checked ? cell.check() : cell.uncheck()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ToDoItemCell
        cell.selectionStyle = .none
        items[indexPath.row].checked = !items[indexPath.row].checked
        items.sort(by: {$1.checked && !$0.checked})
        saveItems()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        items[indexPath.row].checked = !items[indexPath.row].checked
        items.sort(by: {$1.checked && !$0.checked})
        saveItems()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Delete",
                               handler: { [self] (action, view, completionHandler) in
                                   self.items.remove(at: indexPath.row)
                                   self.saveItems()
                                   completionHandler(true)
                                   self.tabelView.reloadData()
                               })
        ])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        changingItemIndex = indexPath.row
        
        let configuration = UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .normal, title: "Edit", handler: { [weak self] (action, view, completionHandler) in
                self?.performSegue(withIdentifier: "editDoneSegue", sender: action)
                completionHandler(true)
            })
        ])
        return configuration
    }
}

extension ToDoViewController {
    func saveItems() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(items)
            defaults.set(data, forKey: itemsKey)
        }
        catch {
            print("Unable to Encode Array of Items (\(error))")
        }
    }
    
    func getItems() -> [Item] {
        if let data = defaults.data(forKey: itemsKey) {
            let decoder = JSONDecoder()
            
            do {
                return try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Unable to Decode Items (\(error))")
            }
        }
        return []
    }
}
