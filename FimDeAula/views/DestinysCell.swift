//
//  DestinysCell.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class DestinyCell: UITableViewCell {
    static var destinyCellIdentifier = "destinyCellIdentifier"
    var checkBoxImageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.contentView.backgroundColor = ThemeColor.shared.cellBackgroundColor
        self.backgroundColor = ThemeColor.shared.tableViewBackgroundColor
        self.selectionStyle = UITableViewCellSelectionStyle.none
        addCheckBox()
        addTitle()
    }
    
    func addCheckBox() {
        self.contentView.addSubview(checkBoxImageView)
        
        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxImageView.image = #imageLiteral(resourceName: "nextIcon")
        
        checkBoxImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        checkBoxImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        checkBoxImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkBoxImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
    }
    func addTitle() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: checkBoxImageView.leftAnchor, constant: -10).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = ThemeColor.shared.textColor
    }
}
