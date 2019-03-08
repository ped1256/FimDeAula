//
//  DaysCell.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class DaysCell: UICollectionViewCell {
    
    static var identifier = "dayCellIdentifier"
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
        buildLabel()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.contentView.backgroundColor = ThemeColor.shared.cellBackgroundColor
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
    }
    
    func buildLabel(){
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        titleLabel.numberOfLines = 1
        titleLabel.textColor = ThemeColor.shared.cellTitleColor
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
    }

    override func prepareForReuse() {
        self.contentView.backgroundColor = ThemeColor.shared.cellBackgroundColor
        self.titleLabel.textColor = ThemeColor.shared.cellTitleColor
    }
}
