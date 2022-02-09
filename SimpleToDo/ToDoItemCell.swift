//
//  ToDoItemCell.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 16.02.2022.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    let CheckedImage = UIImage(systemName: "checkmark.seal")
    let UnCheckedImage = UIImage(systemName: "seal")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func check() {
        self.checkImage.image = CheckedImage
        self.label.textColor = .gray
        self.backgroundColor = .secondarySystemBackground
    }

    func uncheck() {
        self.checkImage.image = UnCheckedImage
        self.label.textColor = .black
        self.backgroundColor = .white
    }
}
