//
//  EditToDoViewController.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 17.02.2022.
//

import UIKit

class EditToDoViewController: UIViewController {
    @IBOutlet weak var toDoText: UITextField!
    
    @IBAction func toDoChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        item = text
    }
    
    private var index = 0
    private var item: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoText.text = item
        toDoText.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func edit(index: Int, item: String) {
        self.index = index
        self.item = item
    }
    
    func getIndex() -> Int { return index }
    func getEditedItem() -> String { return toDoText.text ?? "" }
}
