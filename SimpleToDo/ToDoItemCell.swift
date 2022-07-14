//
//  ToDoItemCell.swift
//  SimpleToDo
//
//  Created by Мария Газизова on 16.02.2022.
//

import UIKit

enum ImageConstants {
    static let checked = "checkmark.seal"
    static let unchecked = "seal"
}
class ToDoItemCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    private let checkedImage = UIImage(systemName: ImageConstants.checked)
    private let unCheckedImage = UIImage(systemName: ImageConstants.unchecked)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func check() {
        self.checkImage.image = checkedImage
        self.label.textColor = .gray
        self.backgroundColor = .secondarySystemBackground
    }

    func uncheck() {
        self.checkImage.image = unCheckedImage
        self.label.textColor = .black
        self.backgroundColor = .white
    }
}
