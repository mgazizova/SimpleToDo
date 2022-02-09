//
//  AddToDoViewController.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 16.02.2022.
//

import UIKit

class AddToDoViewController: UIViewController {
    @IBOutlet weak var toDoText: UITextField!
    
    var item: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoText.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            item = toDoText.text ?? ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
