//
//  Item.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 17.02.2022.
//
struct Item : Codable {
    var text: String
    var checked = false
    
    init(text: String) {
        self.text = text
    }
}
