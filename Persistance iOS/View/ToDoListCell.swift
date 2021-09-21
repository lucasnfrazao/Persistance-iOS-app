//
//  ToDoListCell.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 20/09/21.
//

import UIKit

class ToDoListCell: UITableViewCell {

    lazy var title : UILabel = {
        let view = UILabel()
        view.textColor = .label
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
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
