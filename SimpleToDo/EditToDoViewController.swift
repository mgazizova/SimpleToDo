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
        item = toDoText.text ?? ""
    }
    var index = 0
    var item: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoText.text = item
        toDoText.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
