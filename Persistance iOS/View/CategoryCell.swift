//
//  ToDoListCell.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 20/09/21.
//

import UIKit
import SwipeCellKit

class CategoryCell: SwipeTableViewCell {

    lazy var title : UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = UIFont.boldSystemFont(ofSize: 40)
        return view
    }()
    
    lazy var emoji : UILabel = {
        let emoji = UILabel()
        emoji.font = UIFont.boldSystemFont(ofSize: 25)
        return emoji
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(title)
        self.addSubview(emoji)
        emoji.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        
        emoji.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        emoji.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
