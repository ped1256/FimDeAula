//
//  DaysView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 14/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class CalendarDaysView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var daysCollectioView: UICollectionView?
    var cellSelectedIndex: Int = -1
    static var identifier = "calendarDaysViewIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 96, height: 42)
        layout.headerReferenceSize = layout.itemSize
        
        self.daysCollectioView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        guard let daysCollectioView = daysCollectioView else { return }
        daysCollectioView.delegate = self
        daysCollectioView.dataSource = self
        
        self.addSubview(daysCollectioView)
        
        daysCollectioView.register(DaysCell.self, forCellWithReuseIdentifier: DaysCell.identifier)
        
        daysCollectioView.translatesAutoresizingMaskIntoConstraints = false
        daysCollectioView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -90).isActive = true
        daysCollectioView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        daysCollectioView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        daysCollectioView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        daysCollectioView.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.4235294118, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCell.identifier, for: indexPath) as? DaysCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == cellSelectedIndex {
            cell.contentView.backgroundColor = .white
            cell.titleLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Segunda"
        case 1:
            cell.titleLabel.text = "Terça"
        case 2:
            cell.titleLabel.text = "Quarta"
        case 3:
            cell.titleLabel.text = "Quinta"
        case 4:
            cell.titleLabel.text = "Sexta"
        case 5:
            cell.titleLabel.text = "Sabado"
        case 6:
            cell.titleLabel.text = "Domingo"
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DaysCell else { return }
        cellSelectedIndex = indexPath.row
        
        cell.contentView.backgroundColor = .white
        cell.titleLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        cellSelectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
